<?php

namespace App\Services;

use App\Entity\Menu;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;

Class Parameters {
    protected UrlGeneratorInterface $urlGenerator;
    protected EntityManagerInterface $em;
    public function __construct(UrlGeneratorInterface $urlGenerator, EntityManagerInterface $em)
    {
        $this->urlGenerator = $urlGenerator;
        $this->em = $em;
    }

    protected array $menus = [];
    public function getMenus($makeFlush = false): array
    {
        $this->menus = [
            [
                'heading'    => 'Configuration',
                'title'      => 'Application',
                'icon'       => '<span class="svg-icon svg-icon-2">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M11.2929 2.70711C11.6834 2.31658 12.3166 2.31658 12.7071 2.70711L15.2929 5.29289C15.6834 5.68342 15.6834 6.31658 15.2929 6.70711L12.7071 9.29289C12.3166 9.68342 11.6834 9.68342 11.2929 9.29289L8.70711 6.70711C8.31658 6.31658 8.31658 5.68342 8.70711 5.29289L11.2929 2.70711Z" fill="currentColor"></path>
                                        <path d="M11.2929 14.7071C11.6834 14.3166 12.3166 14.3166 12.7071 14.7071L15.2929 17.2929C15.6834 17.6834 15.6834 18.3166 15.2929 18.7071L12.7071 21.2929C12.3166 21.6834 11.6834 21.6834 11.2929 21.2929L8.70711 18.7071C8.31658 18.3166 8.31658 17.6834 8.70711 17.2929L11.2929 14.7071Z" fill="currentColor"></path>
                                        <path opacity="0.3" d="M5.29289 8.70711C5.68342 8.31658 6.31658 8.31658 6.70711 8.70711L9.29289 11.2929C9.68342 11.6834 9.68342 12.3166 9.29289 12.7071L6.70711 15.2929C6.31658 15.6834 5.68342 15.6834 5.29289 15.2929L2.70711 12.7071C2.31658 12.3166 2.31658 11.6834 2.70711 11.2929L5.29289 8.70711Z" fill="currentColor"></path>
                                        <path opacity="0.3" d="M17.2929 8.70711C17.6834 8.31658 18.3166 8.31658 18.7071 8.70711L21.2929 11.2929C21.6834 11.6834 21.6834 12.3166 21.2929 12.7071L18.7071 15.2929C18.3166 15.6834 17.6834 15.6834 17.2929 15.2929L14.7071 12.7071C14.3166 12.3166 14.3166 11.6834 14.7071 11.2929L17.2929 8.70711Z" fill="currentColor"></path>
                                    </svg>
                                </span>',
                'route'      => '',
                'submenus'   => [
                    [
                        'title'      => 'Menu',
                        'route'      => 'app_menu_index',
                        'roles'      =>'ROLE_MENU',
                    ],
                ],
            ],

            [
                'heading'    => 'ADMINISTRATION',
                'title'      => 'Sécurité',
                'icon'       => '<span class="svg-icon svg-icon-2">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M11.2929 2.70711C11.6834 2.31658 12.3166 2.31658 12.7071 2.70711L15.2929 5.29289C15.6834 5.68342 15.6834 6.31658 15.2929 6.70711L12.7071 9.29289C12.3166 9.68342 11.6834 9.68342 11.2929 9.29289L8.70711 6.70711C8.31658 6.31658 8.31658 5.68342 8.70711 5.29289L11.2929 2.70711Z" fill="currentColor"></path>
                                        <path d="M11.2929 14.7071C11.6834 14.3166 12.3166 14.3166 12.7071 14.7071L15.2929 17.2929C15.6834 17.6834 15.6834 18.3166 15.2929 18.7071L12.7071 21.2929C12.3166 21.6834 11.6834 21.6834 11.2929 21.2929L8.70711 18.7071C8.31658 18.3166 8.31658 17.6834 8.70711 17.2929L11.2929 14.7071Z" fill="currentColor"></path>
                                        <path opacity="0.3" d="M5.29289 8.70711C5.68342 8.31658 6.31658 8.31658 6.70711 8.70711L9.29289 11.2929C9.68342 11.6834 9.68342 12.3166 9.29289 12.7071L6.70711 15.2929C6.31658 15.6834 5.68342 15.6834 5.29289 15.2929L2.70711 12.7071C2.31658 12.3166 2.31658 11.6834 2.70711 11.2929L5.29289 8.70711Z" fill="currentColor"></path>
                                        <path opacity="0.3" d="M17.2929 8.70711C17.6834 8.31658 18.3166 8.31658 18.7071 8.70711L21.2929 11.2929C21.6834 11.6834 21.6834 12.3166 21.2929 12.7071L18.7071 15.2929C18.3166 15.6834 17.6834 15.6834 17.2929 15.2929L14.7071 12.7071C14.3166 12.3166 14.3166 11.6834 14.7071 11.2929L17.2929 8.70711Z" fill="currentColor"></path>
                                    </svg>
                                </span>',
                'route'      => '',
                'submenus'   => [
                    [
                        'title'      => 'Profil',
                        'route'      => 'app_profil_index',
                        'roles'      =>'ROLE_PROFIL',
                    ],
                    [
                        'title'      => 'Utilisateur',
                        'route'      => 'app_utilisateur_index',
                        'roles'      =>'ROLE_UTILISATEUR',
                    ],
                    [
                        'title'      => 'Configuration',
                        'route'      => 'app_configuration_index',
                        'roles'      =>'ROLE_CONFIGURATION',

                    ],
                ],
            ],
            [
                'heading'    => 'Etat et Statistique',
                'title'      => 'Etat',
                'icon'       => '<span class="svg-icon svg-icon-2">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M11.2929 2.70711C11.6834 2.31658 12.3166 2.31658 12.7071 2.70711L15.2929 5.29289C15.6834 5.68342 15.6834 6.31658 15.2929 6.70711L12.7071 9.29289C12.3166 9.68342 11.6834 9.68342 11.2929 9.29289L8.70711 6.70711C8.31658 6.31658 8.31658 5.68342 8.70711 5.29289L11.2929 2.70711Z" fill="currentColor"></path>
                                        <path d="M11.2929 14.7071C11.6834 14.3166 12.3166 14.3166 12.7071 14.7071L15.2929 17.2929C15.6834 17.6834 15.6834 18.3166 15.2929 18.7071L12.7071 21.2929C12.3166 21.6834 11.6834 21.6834 11.2929 21.2929L8.70711 18.7071C8.31658 18.3166 8.31658 17.6834 8.70711 17.2929L11.2929 14.7071Z" fill="currentColor"></path>
                                        <path opacity="0.3" d="M5.29289 8.70711C5.68342 8.31658 6.31658 8.31658 6.70711 8.70711L9.29289 11.2929C9.68342 11.6834 9.68342 12.3166 9.29289 12.7071L6.70711 15.2929C6.31658 15.6834 5.68342 15.6834 5.29289 15.2929L2.70711 12.7071C2.31658 12.3166 2.31658 11.6834 2.70711 11.2929L5.29289 8.70711Z" fill="currentColor"></path>
                                        <path opacity="0.3" d="M17.2929 8.70711C17.6834 8.31658 18.3166 8.31658 18.7071 8.70711L21.2929 11.2929C21.6834 11.6834 21.6834 12.3166 21.2929 12.7071L18.7071 15.2929C18.3166 15.6834 17.6834 15.6834 17.2929 15.2929L14.7071 12.7071C14.3166 12.3166 14.3166 11.6834 14.7071 11.2929L17.2929 8.70711Z" fill="currentColor"></path>
                                    </svg>
                                </span>',
                'route'      => '',
                'submenus'   => [
                    [
                        'title'      => 'Statistiques du stocks',
                        'route'      => 'romassigcom_mouvement_stock',
                        'roles'      =>'ROLE_MOUVEMENT_STOCK',
                    ],
                    [
                        'title'      => 'Statistique des ventes',
                        'route'      => 'romassigcom_statistique_vente',
                        'roles'      =>'ROLE_STAT_VENTE',
                    ],
                    [
                        'title'      => 'Statistique de la caisse',
                        'route'      => 'romassigcom_point_reglement',
                        'roles'      => 'ROLE_ETAT_CAISSE',
                    ],
                    [
                        'title'      => 'Statistique des produits',
                        'route'      => 'romassigcom_etat_produit',
                        'roles'      =>'ROLE_ETAT_PRODUIT',
                    ],
                    [
                        'title'      => 'Statistique des clients',
                        'route'      => 'romassigcom_etat_client',
                        'roles'      =>'ROLE_ETAT_CLIENT',

                    ],
                    [
                        'title'      => 'Fiche de recensement des carreaux',
                        'route'      => 'romassigcom_etat_fiche',
                        'roles'      =>'ROLE_ETAT_FICHE',
                    ],
                ],
            ],
            [
                'heading'    => 'STANDARD',
                'title'      => 'Paramètre',
                'icon'       => '<span class="svg-icon svg-icon-2">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path opacity="0.3" d="M22.1 11.5V12.6C22.1 13.2 21.7 13.6 21.2 13.7L19.9 13.9C19.7 14.7 19.4 15.5 18.9 16.2L19.7 17.2999C20 17.6999 20 18.3999 19.6 18.7999L18.8 19.6C18.4 20 17.8 20 17.3 19.7L16.2 18.9C15.5 19.3 14.7 19.7 13.9 19.9L13.7 21.2C13.6 21.7 13.1 22.1 12.6 22.1H11.5C10.9 22.1 10.5 21.7 10.4 21.2L10.2 19.9C9.4 19.7 8.6 19.4 7.9 18.9L6.8 19.7C6.4 20 5.7 20 5.3 19.6L4.5 18.7999C4.1 18.3999 4.1 17.7999 4.4 17.2999L5.2 16.2C4.8 15.5 4.4 14.7 4.2 13.9L2.9 13.7C2.4 13.6 2 13.1 2 12.6V11.5C2 10.9 2.4 10.5 2.9 10.4L4.2 10.2C4.4 9.39995 4.7 8.60002 5.2 7.90002L4.4 6.79993C4.1 6.39993 4.1 5.69993 4.5 5.29993L5.3 4.5C5.7 4.1 6.3 4.10002 6.8 4.40002L7.9 5.19995C8.6 4.79995 9.4 4.39995 10.2 4.19995L10.4 2.90002C10.5 2.40002 11 2 11.5 2H12.6C13.2 2 13.6 2.40002 13.7 2.90002L13.9 4.19995C14.7 4.39995 15.5 4.69995 16.2 5.19995L17.3 4.40002C17.7 4.10002 18.4 4.1 18.8 4.5L19.6 5.29993C20 5.69993 20 6.29993 19.7 6.79993L18.9 7.90002C19.3 8.60002 19.7 9.39995 19.9 10.2L21.2 10.4C21.7 10.5 22.1 11 22.1 11.5ZM12.1 8.59998C10.2 8.59998 8.6 10.2 8.6 12.1C8.6 14 10.2 15.6 12.1 15.6C14 15.6 15.6 14 15.6 12.1C15.6 10.2 14 8.59998 12.1 8.59998Z" fill="currentColor"></path>
                                        <path d="M17.1 12.1C17.1 14.9 14.9 17.1 12.1 17.1C9.30001 17.1 7.10001 14.9 7.10001 12.1C7.10001 9.29998 9.30001 7.09998 12.1 7.09998C14.9 7.09998 17.1 9.29998 17.1 12.1ZM12.1 10.1C11 10.1 10.1 11 10.1 12.1C10.1 13.2 11 14.1 12.1 14.1C13.2 14.1 14.1 13.2 14.1 12.1C14.1 11 13.2 10.1 12.1 10.1Z" fill="currentColor"></path>
                                    </svg>
                                </span>',
                'route'      => '',
                'submenus'   => [
                    [
                        'title'      => 'Société',
                        'route'      => 'app_societe_index',
                        'roles'      =>'ROLE_SOCIETE',
                    ],
                    [
                        'title'      => 'Famille',
                        'route'      => 'app_famille_index',
                        'roles'      => 'ROLE_FAMILLE',
                    ],
                    [
                        'title'      => 'Produit',
                        'route'      => 'app_produit_index',
                        'roles'      =>'ROLE_PRODUIT',
                    ],
                    [
                        'title'      => 'Personnel',
                        'route'      => 'app_personnel_index',
                        'roles'      => 'ROLE_PERSONNEL',
                    ],
                    [
                        'title'      => 'Fonction',
                        'route'      => 'app_fonction_index',
                        'roles'      => 'ROLE_FONCTION',
                    ],
                    [
                        'title'      => 'Mode de paiement',
                        'route'      => 'app_mode_paiement_index',
                        'roles'      => 'ROLE_MODE_DE_PAIEMENT',
                    ],
                    [
                        'title'      => 'Banque',
                        'route'      => 'app_banque_index',
                        'roles'      => 'ROLE_BANQUE',
                    ],
                    [
                        'title'      => 'Magasin',
                        'route'      => 'app_magasin_index',
                        'roles'      => 'ROLE_MAGASIN',
                    ],
                    [
                        'title'      => 'Conditionnement',
                        'route'      => 'app_conditionnement_index',
                        'roles'      => 'ROLE_CONDITIONNEMENT',
                    ],
                    [
                        'title'      => 'Client',
                        'route'      => 'app_client_index',
                        'roles'      => 'ROLE_CLIENT',
                    ],
                    [
                        'title'      => 'Fournisseur',
                        'route'      => 'app_fournisseur_index',
                        'roles'      => 'ROLE_FOURNISSEUR',
                    ],
                    [
                        'title'      => 'Monnaie',
                        'route'      => 'app_monnaie_index',
                        'roles'      => 'ROLE_MONNAIE',
                    ],
                    [
                        'title'      => 'Caisse',
                        'route'      => 'app_list_caisse_index',
                        'roles'      => 'ROLE_CAISSE',
                    ],
                    [
                        'title'      => 'Type d\'opération',
                        'route'      => 'app_type_operation_index',
                        'roles'      =>'ROLE_TYPE_OPERATION',
                    ],
                    [
                        'title'      => 'Taxe',
                        'route'      => 'app_taxe_index',
                        'roles'      =>'ROLE_TAXE',
                    ],
                    [
                        'title'      => 'Point de vente',
                        'route'      => 'app_point_de_vente_index',
                        'roles'      =>'ROLE_POINT_VENTE',
                    ],
                    [
                        'title'      => 'Modèle Signataire',
                        'route'      => 'app_model_signataire_index',
                        'roles'      => 'ROLE_MODEL_SIGNATAIRE',
                    ],
                    [
                        'title'      => 'Type de Dépense',
                        'route'      => 'app_type_depense_index',
                        'roles'      => 'ROLE_TYPE_DEPENSE',
                    ],
                ],
            ],
            [
                'heading'    => '',
                'title'      => 'Gestion de la vente',
                'icon'       => '<span class="svg-icon svg-icon-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512" fill="currentColor">
                                        <!--! Font Awesome Free 6.3.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2023 Fonticons, Inc. -->
                                        <path d="M64 0C46.3 0 32 14.3 32 32V96c0 17.7 14.3 32 32 32h80v32H87c-31.6 0-58.5 23.1-63.3 54.4L1.1 364.1C.4 368.8 0 373.6 0 378.4V448c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V378.4c0-4.8-.4-9.6-1.1-14.4L488.2 214.4C483.5 183.1 456.6 160 425 160H208V128h80c17.7 0 32-14.3 32-32V32c0-17.7-14.3-32-32-32H64zM96 48H256c8.8 0 16 7.2 16 16s-7.2 16-16 16H96c-8.8 0-16-7.2-16-16s7.2-16 16-16zM64 432c0-8.8 7.2-16 16-16H432c8.8 0 16 7.2 16 16s-7.2 16-16 16H80c-8.8 0-16-7.2-16-16zm48-168a24 24 0 1 1 0-48 24 24 0 1 1 0 48zm120-24a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM160 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48zM328 240a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM256 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48zM424 240a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM352 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48z"/>
                                    </svg>
                                </span>',
                'route'      => '',
                'submenus'   => [
                    [
                        'title'      => 'Vente',
                        'route'      => 'app_commande_client_index',
                        'roles'      =>'ROLE_COMMANDE_CLIENT',
                    ],
                ],
            ],
            [
                'heading'    => '',
                'title'      => 'Gestion de stock',
                'icon'       => '<span class="svg-icon svg-icon-2">
                                    <svg style="color: white" width="48" height="48" viewBox="0 0 48 48"  fill="none" xmlns="http://www.w3.org/2000/svg"> 
                                        <path d="M27.707 6.29289C28.0975 6.68342 28.0975 7.31658 27.707 7.70711L25.4143 9.99976L27.7071 12.2925C28.0976 12.683 28.0976 13.3162 27.7071 13.7067C27.3166 14.0973 26.6834 14.0973 26.2929 13.7067L24.0001 11.414L21.7074 13.7067C21.3168 14.0973 20.6837 14.0973 20.2931 13.7067C19.9026 13.3162 19.9026 12.683 20.2931 12.2925L22.5859 9.99976L20.2933 7.70711C19.9027 7.31658 19.9027 6.68342 20.2933 6.29289C20.6838 5.90237 21.317 5.90237 21.7075 6.29289L24.0001 8.58554L26.2928 6.29289C26.6833 5.90237 27.3165 5.90237 27.707 6.29289Z" fill="white"></path> 
                                        <path d="M19.1975 32.7281C20.5767 33.1878 22.0855 32.7454 23 31.6401L23 42.0231L11 37.5V29.9956L19.1975 32.7281Z" fill="white"></path> 
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M37 37.5L25 42.0231V31.6401C25.9145 32.7454 27.4234 33.1878 28.8025 32.7281L37 29.9956V37.5Z" fill="white"></path> 
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M24.3271 15.055C24.1152 14.9817 23.8848 14.9817 23.6729 15.055L10.6748 19.5544L10.6525 19.5623C10.4711 19.6295 10.3204 19.7441 10.2096 19.8872L6.21914 24.8753C6.01489 25.1306 5.94836 25.4697 6.04096 25.7832C6.13356 26.0968 6.3736 26.3453 6.68378 26.4487L20.1838 30.9487C20.6036 31.0886 21.0655 30.936 21.3192 30.5735L24 26.7438L26.6808 30.5735C26.9346 30.936 27.3964 31.0886 27.8162 30.9487L41.3162 26.4487C41.6264 26.3453 41.8665 26.0968 41.9591 25.7832C42.0517 25.4697 41.9851 25.1306 41.7809 24.8753L37.7904 19.8872C37.6803 19.7449 37.5306 19.6307 37.3505 19.5634C37.3421 19.5603 37.3336 19.5572 37.3251 19.5543L24.3271 15.055ZM24 23.9418L33.9429 20.5L24 17.0582L14.0571 20.5L24 23.9418Z" fill="white"></path> 
                                    </svg>
                                </span>',
                'route'      => '',
                'submenus'   => [
                    [
                        'title'      => 'Suivi de Stock',
                        'route'      => 'app_stock_en_unite',
                        'roles'      => 'ROLE_SUIVI_STOCK',
                    ],
                    [
                        'title'      => 'Approvisionnement',
                        'route'      => 'app_approvisionnement_index',
                        'roles'      =>'ROLE_APPROVISIONNEMENT',
                    ],
                    [
                        'title'      => 'Détachement',
                        'route'      => 'app_detachement_index',
                        'roles'      => 'ROLE_LIVRAISON',
                    ],
                    [
                        'title'      => 'Sortie',
                        'route'      => 'app_sortie_index',
                        'roles'      => 'ROLE_SORTIE',
                    ],
                    [
                        'title'      => 'Transfert',
                        'route'      => 'app_transfert_index',
                        'roles'      => 'ROLE_TRANSFERT',
                    ],
                    [
                        'title'      => 'Livraison client',
                        'route'      => 'app_livraison_index',
                        'roles'      => 'ROLE_LIVRAISON',
                    ],
                    [
                        'title'      => 'Inventaire',
                        'route'      => 'app_inventaire_index',
                        'roles'      => 'ROLE_INVENTAIRE',
                    ],
                ],
            ],
            [
                'heading'    => '',
                'title'      => 'Gestion de portefeuilles',
                'icon'       => '<span class="svg-icon svg-icon-2">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                 viewBox="0 0 24 24" fill="none">
                                                <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor"/>
                                                <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                                                      fill="currentColor"/>
                                                <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                                                      fill="currentColor"/>
                                                <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                                                      fill="currentColor"/>
                                            </svg>
                                        </span>',
                'route'      => '',
                'submenus'   => [
                    [
                        'title'      => 'Transaction',
                        'route'      => 'app_transaction_index',
                        'roles'      =>'ROLE_TRANSACTION',
                    ],
                    [
                        'title'      => 'Compte',
                        'route'      => 'app_compte_index',
                        'roles'      =>'ROLE_COMPTE',
                    ],
                ],
            ],
            [
                'heading'    => '',
                'title'      => 'Gestion de la caisse',
                'icon'       => '<span class="svg-icon svg-icon-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512" fill="currentColor">
                                        <!--! Font Awesome Free 6.3.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2023 Fonticons, Inc. -->
                                        <path d="M64 0C46.3 0 32 14.3 32 32V96c0 17.7 14.3 32 32 32h80v32H87c-31.6 0-58.5 23.1-63.3 54.4L1.1 364.1C.4 368.8 0 373.6 0 378.4V448c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V378.4c0-4.8-.4-9.6-1.1-14.4L488.2 214.4C483.5 183.1 456.6 160 425 160H208V128h80c17.7 0 32-14.3 32-32V32c0-17.7-14.3-32-32-32H64zM96 48H256c8.8 0 16 7.2 16 16s-7.2 16-16 16H96c-8.8 0-16-7.2-16-16s7.2-16 16-16zM64 432c0-8.8 7.2-16 16-16H432c8.8 0 16 7.2 16 16s-7.2 16-16 16H80c-8.8 0-16-7.2-16-16zm48-168a24 24 0 1 1 0-48 24 24 0 1 1 0 48zm120-24a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM160 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48zM328 240a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM256 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48zM424 240a24 24 0 1 1 -48 0 24 24 0 1 1 48 0zM352 344a24 24 0 1 1 0-48 24 24 0 1 1 0 48z"/>
                                    </svg>
                                </span>',
                'route'      => '',
                'submenus'   => [
                    [
                        'title'      => 'Paiement',
                        'route'      => 'app_paiement_index',
                        'roles'      =>'ROLE_PAIEMENT',
                    ],
                    [
                        'title'      => 'Dépôt',
                        'route'      => 'app_transaction_depot',
                        'roles'      => 'ROLE_DEPOT',
                    ],
                    [
                        'title'      => 'Dépense',
                        'route'      => 'app_depense_index',
                        'roles'      => 'ROLE_DEPENSE',
                    ],
                ],
            ],
            [
                'heading'    => '',
                'title'      => 'Gestion des fournisseurs',
                'icon'       => '<span class="svg-icon svg-icon-2">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                 viewBox="0 0 24 24" fill="none">
                                                <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor"/>
                                                <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                                                      fill="currentColor"/>
                                                <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                                                      fill="currentColor"/>
                                                <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                                                      fill="currentColor"/>
                                            </svg>
                                        </span>',
                'route'      => '',
                'submenus'   => [
                    [
                        'title'      => 'Demande de prix',
                        'route'      => 'app_demande_de_prix_index',
                        'roles'      => 'ROLE_DEMANDE_PRIX',
                    ],
                    [
                        'title'      => 'Commande fournisseur',
                        'route'      => 'app_commande_frs_index',
                        'roles'      => 'ROLE_COMMANDE_FRS',
                    ],
                ],
            ],
            [
                'heading'    => '',
                'title'      => 'Gestion des factures',
                'icon'       => '<span class="svg-icon svg-icon-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                            viewBox="0 0 24 24" fill="none">
                                        <rect x="2" y="2" width="9" height="9" rx="2" fill="currentColor"/>
                                        <rect opacity="0.3" x="13" y="2" width="9" height="9" rx="2"
                                                fill="currentColor"/>
                                        <rect opacity="0.3" x="13" y="13" width="9" height="9" rx="2"
                                                fill="currentColor"/>
                                        <rect opacity="0.3" x="2" y="13" width="9" height="9" rx="2"
                                                fill="currentColor"/>
                                    </svg>
                                </span>',
                'route'      => '',
                'submenus'   => [
                    [
                        'title'      => 'Facture',
                        'route'      => 'app_facture_index',
                        'roles'      => 'ROLE_FACTURE',
                    ],
                    [
                        'title'      => 'Facture proforma',
                        'route'      => 'app_facture_proforma_index',
                        'roles'      => 'ROLE_FACTURE_PRO_FORMA',
                    ],
                ],
            ],
        ];

        return $this->menuToObject($this->menus, null, $makeFlush);
    }

    public function menuToObject($allMenus, $parentMenu = null, $makeFlush = false): array
    {
        $entities = [];
        foreach ($allMenus as $menu)
        {
            $_menu = new Menu();
            $find_menu = $this->em->getRepository(Menu::class)->findOneBy(['titre' => $menu['title']]);
            if($find_menu != null)
                $_menu = $find_menu;
            $_menu->setSousTitre(in_array('heading', array_keys($menu)) ? $menu['heading'] : null);
            $_menu->setTitre(in_array('title', array_keys($menu)) ? $menu['title'] : null);
            $_menu->setUrl(in_array('route', array_keys($menu)) ? $menu['route'] : null);
            $_menu->setRoles(in_array('roles', array_keys($menu)) ? $menu['roles'] : '');
            $_menu->setIcon(in_array('icon', array_keys($menu)) ? $menu['icon'] : null);
            $_menu->setActive(0);
            if($parentMenu != null)
                $parentMenu->addSousMenu($_menu);
            if(in_array('submenus', array_keys($menu)) && sizeof($menu['submenus']) > 0)
            {
                $this->menuToObject($menu['submenus'], $_menu);
            }
            if($makeFlush)
            {
                $this->em->persist($_menu);
                $this->em->flush();
            }
            $entities[] = $_menu;
        }
        return $entities;
    }
}