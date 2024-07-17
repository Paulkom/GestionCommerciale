<?php

namespace App\Services;

use GuzzleHttp\Client;
use App\Entity\CommandeClient;
use App\Services\lib\Configuration;
use App\Services\lib\Model\ItemDto;
use App\Services\lib\Api\SfeInfoApi;
use App\Services\lib\Model\ClientDto;
use App\Services\lib\Api\SfeInvoiceApi;
use App\Services\lib\Model\AibGroupTypeEnum;
use App\Services\lib\Model\OperatorDto;
use App\Services\lib\Model\InvoiceTypeEnum;
use App\Services\lib\Model\TaxGroupTypeEnum;
use Symfony\Component\Security\Core\Security;
use App\Services\lib\Model\InvoiceRequestDataDto;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class ApiMecef
{
    // private $societe;
    // private $agent;
    public function __construct(SessionInterface $session, Security $security)
    {
        // $this->societe = $session->get('societe', []);
        // $this->agent = $security->getUser();
    }

    public function normalise($typeFacture, $entity, $agent, $societe, $reference = null){

    

        $mecefIFU = $societe['ifu'];
        $mecefNim = $societe['nim'];
        $mecefToken = $societe['token'];
        $mecefHost = $societe['host'];
       
        $agent = $agent->getPersonnel()->getId().' '.$agent->getPersonnel()->getPrenoms();

        /**
         * @var CommandeClient $entity
         */
        $acheteur = $entity->getAcheteur();

        if($mecefNim == '' || $mecefToken == '' || $mecefIFU == '' ){
            return throw new \Exception('Veuillez revoir la configuration de la société');
        }

        if($agent == ''){
            return throw new \Exception('Agent non défini');
        }

        if($acheteur == ''){
            return throw new \Exception('Acheteur non défini');
        }

        $invoiceResponseDto = null;

        // Configure API key authorization: Bearer
        $config = Configuration::getDefaultConfiguration()->setApiKey('Authorization', $mecefToken);
        $config->setHost($mecefHost);

        $apiInvoiceInstance = new SfeInvoiceApi(
            new Client(array('verify'=> false)),
            $config
        );

        $apiInfoInstance = new SfeInfoApi(
            new Client(array('verify'=> false)),
            $config
        );

        //INFO
        try {
            $infoResponseDto = $apiInfoInstance->apiInfoStatusGet();
        } catch (\Exception $e) {
            return  '1 Exception when calling SfeInvoiceApi->apiInvoiceGet: '. $e->getMessage(). PHP_EOL;
            // return new JsonResponse("Veuillez revoir les configurations afin de normaliser la facture");
        }
        
        try {
            $invoiceTypesDto = $apiInfoInstance->apiInfoInvoiceTypesGet();
        } catch (\Exception $e) {
            return '2 Exception when calling SfeInvoiceApi->apiInvoiceGet: '. $e->getMessage(). PHP_EOL;
        }
        
        try {
            $taxGroupsDto = $apiInfoInstance->apiInfoTaxGroupsGet();
        } catch (\Exception $e) {
            return '3 Exception when calling SfeInvoiceApi->apiInvoiceGet: '. $e->getMessage(). PHP_EOL;
        }
        
        try {
            $paymentTypesDto = $apiInfoInstance->apiInfoPaymentTypesGet();
        } catch (\Exception $e) {
            return '4 Exception when calling SfeInvoiceApi->apiInvoiceGet: '. $e->getMessage(). PHP_EOL;
        }
        
        //INVOICE
        try {
            $statusReponseDto = $apiInvoiceInstance->apiInvoiceGet();
        } catch (\Exception $e) {
            return '5 Exception when calling SfeInvoiceApi->apiInvoiceGet: '. $e->getMessage(). PHP_EOL;
        }
        
        $body = new InvoiceRequestDataDto();
        $body->setIfu($mecefIFU);
        
        
        $client = new ClientDto();
        if($acheteur->getStatut() == 'Physique'){
            $client->setName($acheteur->getNom().' '.$acheteur->getPrenom());
            $client->setAddress($acheteur->getAdresse());
            $client->setIfu(($acheteur->getIfu() != '') ? $acheteur->getIfu() : null);
            $client->setContact( ($acheteur->getTelephone1() != '') ? $acheteur->getTelephone1() : null);
            
        }elseif($acheteur->getStatut() == 'Moral'){

            $client->setName($acheteur->getRaisonSociale());
            $client->setAddress($acheteur->getAdresse());
            $client->setIfu(($acheteur->getIfu() != '') ? $acheteur->getIfu() : null);
            $client->setContact( ($acheteur->getTelephone1() != '') ? $acheteur->getTelephone1() : null);
        }

        $body->setClient($client);

        $operatorDto = new OperatorDto();
        $operatorDto->setName($agent);
        $body->setOperator($operatorDto);

        switch ($typeFacture) {
            case 'FV':
                $body->setType(InvoiceTypeEnum::FV);
                break;
            case 'FA':
                $body->setType(InvoiceTypeEnum::FA);
                $body->setReference($reference);
                break;
            case 'EV':
                $body->setType(InvoiceTypeEnum::EV);
                break;
            case 'EA':
                $body->setType(InvoiceTypeEnum::EA);
                $body->setReference($reference);
                break;

            default:
                throw new \Exception('ERREUR TYPE');
                break;
        }
        // $body->setType(InvoiceTypeEnum::FV);
        

        $items = array();

        if($entity instanceof CommandeClient){
            $produits = $entity->getProduitCondComClits();
            foreach ($produits as $produit) {
                $item = new ItemDto();
                $item->setName($produit->getProduit()->getProduit()->getNomProd());
                $item->setPrice($produit->getPrix());
                $item->setQuantity($produit->getQtite());
                if((float)$produit->getTaxeSpecifique() > 0){  $item->setTaxSpecific($produit->getTaxeSpecifique() / 1.18); }
                $gt = $produit->getProduit()->getProduit()->getGroupeTaxe()->getCodeGr();
                switch ($gt) {
                    case 'A':
                        $item->setTaxGroup(TaxGroupTypeEnum::A);
                        break;
                    case 'B':
                        $item->setTaxGroup(TaxGroupTypeEnum::B);
                        break;
                    case 'C':
                        $item->setTaxGroup(TaxGroupTypeEnum::C);
                        break;
                    case 'D':
                        $item->setTaxGroup(TaxGroupTypeEnum::D);
                        break;
                    case 'E':
                        $item->setTaxGroup(TaxGroupTypeEnum::E);
                        if((float)$produit->getTaxeSpecifique() > 0){ $item->setTaxSpecific($produit->getTaxeSpecifique()); }
                        break;
                    case 'F':
                        $item->setTaxGroup(TaxGroupTypeEnum::F);
                        break;
                    
                    default:
                        throw new \Exception('ERREUR GROUPE DE TAXE');
                        break;
                }
                array_push($items, $item);
            }
            
            // gestion de lAIB
            switch ($entity->getTauxAib()) {
                case '1':
                    $body->setAib(AibGroupTypeEnum::A);
                    break;
                case '5':
                    $body->setAib(AibGroupTypeEnum::B);
                    break;
                
                default:
                    
                    break;
            }

        }
        

        $body->setItems($items);

        try {
            $invoiceResponseDto = $apiInvoiceInstance->apiInvoicePost($body);
            // print_r($invoiceResponseDto);
        } catch (\Exception $e) {
            return '6 Exception when calling SfeInvoiceApi->apiInvoicePost: '. $e->getMessage(). PHP_EOL;
        }

        $securityElementsDto = null;
        $uid = ($invoiceResponseDto) ? $invoiceResponseDto['uid'] : null; // string | 
        if (!is_null($uid)){

            try {
                $invoiceDetailsDto = $apiInvoiceInstance->apiInvoiceUidGet($uid);
                // print_r($invoiceDetailsDto);
                
                    try {
                        $securityElementsDto = $apiInvoiceInstance->apiInvoiceUidConfirmPut($uid);
                        // print_r($securityElementsDto);
                    } catch (\Exception $e) {
                        return '7 Exception when calling SfeInvoiceApi->apiInvoiceUidConfirmPut: '. $e->getMessage(). PHP_EOL;
                    }
                
            } catch (\Exception $e) {
                return '8 Exception when calling SfeInvoiceApi->apiInvoiceUidConfirmPut: '. $e->getMessage(). PHP_EOL;
            }
        }
    
        return $securityElementsDto;
    } 
}