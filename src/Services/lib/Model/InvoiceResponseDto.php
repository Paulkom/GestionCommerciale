<?php


namespace App\Services\lib\Model;

use App\Services\lib\ObjectSerializer;


class InvoiceResponseDto implements ModelInterface, \ArrayAccess
{
    const DISCRIMINATOR = null;

    /**
      * The original name of the model.
      *
      * @var string
      */
    protected static $swaggerModelName = 'InvoiceResponseDto';

    /**
      * Array of property to type mappings. Used for (de)serialization
      *
      * @var string[]
      */
    protected static $swaggerTypes = [
        'uid' => 'string',
'ta' => 'int',
'tb' => 'int',
'tc' => 'int',
'td' => 'int',
'taa' => 'int',
'tab' => 'int',
'tac' => 'int',
'tad' => 'int',
'tae' => 'int',
'taf' => 'int',
'hab' => 'int',
'had' => 'int',
'vab' => 'int',
'vad' => 'int',
'aib' => 'int',
'ts' => 'int',
'total' => 'int',
'error_code' => 'string',
'error_desc' => 'string'    ];

    /**
      * Array of property to format mappings. Used for (de)serialization
      *
      * @var string[]
      */
    protected static $swaggerFormats = [
        'uid' => null,
'ta' => 'int64',
'tb' => 'int64',
'tc' => 'int64',
'td' => 'int64',
'taa' => 'int64',
'tab' => 'int64',
'tac' => 'int64',
'tad' => 'int64',
'tae' => 'int64',
'taf' => 'int64',
'hab' => 'int64',
'had' => 'int64',
'vab' => 'int64',
'vad' => 'int64',
'aib' => 'int64',
'ts' => 'int64',
'total' => 'int64',
'error_code' => null,
'error_desc' => null    ];

    /**
     * Array of property to type mappings. Used for (de)serialization
     *
     * @return array
     */
    public static function swaggerTypes()
    {
        return self::$swaggerTypes;
    }

    /**
     * Array of property to format mappings. Used for (de)serialization
     *
     * @return array
     */
    public static function swaggerFormats()
    {
        return self::$swaggerFormats;
    }

    /**
     * Array of attributes where the key is the local name,
     * and the value is the original name
     *
     * @var string[]
     */
    protected static $attributeMap = [
        'uid' => 'uid',
'ta' => 'ta',
'tb' => 'tb',
'tc' => 'tc',
'td' => 'td',
'taa' => 'taa',
'tab' => 'tab',
'tac' => 'tac',
'tad' => 'tad',
'tae' => 'tae',
'taf' => 'taf',
'hab' => 'hab',
'had' => 'had',
'vab' => 'vab',
'vad' => 'vad',
'aib' => 'aib',
'ts' => 'ts',
'total' => 'total',
'error_code' => 'errorCode',
'error_desc' => 'errorDesc'    ];

    /**
     * Array of attributes to setter functions (for deserialization of responses)
     *
     * @var string[]
     */
    protected static $setters = [
        'uid' => 'setUid',
'ta' => 'setTa',
'tb' => 'setTb',
'tc' => 'setTc',
'td' => 'setTd',
'taa' => 'setTaa',
'tab' => 'setTab',
'tac' => 'setTac',
'tad' => 'setTad',
'tae' => 'setTae',
'taf' => 'setTaf',
'hab' => 'setHab',
'had' => 'setHad',
'vab' => 'setVab',
'vad' => 'setVad',
'aib' => 'setAib',
'ts' => 'setTs',
'total' => 'setTotal',
'error_code' => 'setErrorCode',
'error_desc' => 'setErrorDesc'    ];

    /**
     * Array of attributes to getter functions (for serialization of requests)
     *
     * @var string[]
     */
    protected static $getters = [
        'uid' => 'getUid',
'ta' => 'getTa',
'tb' => 'getTb',
'tc' => 'getTc',
'td' => 'getTd',
'taa' => 'getTaa',
'tab' => 'getTab',
'tac' => 'getTac',
'tad' => 'getTad',
'tae' => 'getTae',
'taf' => 'getTaf',
'hab' => 'getHab',
'had' => 'getHad',
'vab' => 'getVab',
'vad' => 'getVad',
'aib' => 'getAib',
'ts' => 'getTs',
'total' => 'getTotal',
'error_code' => 'getErrorCode',
'error_desc' => 'getErrorDesc'    ];

    /**
     * Array of attributes where the key is the local name,
     * and the value is the original name
     *
     * @return array
     */
    public static function attributeMap()
    {
        return self::$attributeMap;
    }

    /**
     * Array of attributes to setter functions (for deserialization of responses)
     *
     * @return array
     */
    public static function setters()
    {
        return self::$setters;
    }

    /**
     * Array of attributes to getter functions (for serialization of requests)
     *
     * @return array
     */
    public static function getters()
    {
        return self::$getters;
    }

    /**
     * The original name of the model.
     *
     * @return string
     */
    public function getModelName()
    {
        return self::$swaggerModelName;
    }

    

    /**
     * Associative array for storing property values
     *
     * @var mixed[]
     */
    protected $container = [];

    /**
     * Constructor
     *
     * @param mixed[] $data Associated array of property values
     *                      initializing the model
     */
    public function __construct(array $data = null)
    {
        $this->container['uid'] = isset($data['uid']) ? $data['uid'] : null;
        $this->container['ta'] = isset($data['ta']) ? $data['ta'] : null;
        $this->container['tb'] = isset($data['tb']) ? $data['tb'] : null;
        $this->container['tc'] = isset($data['tc']) ? $data['tc'] : null;
        $this->container['td'] = isset($data['td']) ? $data['td'] : null;
        $this->container['taa'] = isset($data['taa']) ? $data['taa'] : null;
        $this->container['tab'] = isset($data['tab']) ? $data['tab'] : null;
        $this->container['tac'] = isset($data['tac']) ? $data['tac'] : null;
        $this->container['tad'] = isset($data['tad']) ? $data['tad'] : null;
        $this->container['tae'] = isset($data['tae']) ? $data['tae'] : null;
        $this->container['taf'] = isset($data['taf']) ? $data['taf'] : null;
        $this->container['hab'] = isset($data['hab']) ? $data['hab'] : null;
        $this->container['had'] = isset($data['had']) ? $data['had'] : null;
        $this->container['vab'] = isset($data['vab']) ? $data['vab'] : null;
        $this->container['vad'] = isset($data['vad']) ? $data['vad'] : null;
        $this->container['aib'] = isset($data['aib']) ? $data['aib'] : null;
        $this->container['ts'] = isset($data['ts']) ? $data['ts'] : null;
        $this->container['total'] = isset($data['total']) ? $data['total'] : null;
        $this->container['error_code'] = isset($data['error_code']) ? $data['error_code'] : null;
        $this->container['error_desc'] = isset($data['error_desc']) ? $data['error_desc'] : null;
    }

    /**
     * Show all the invalid properties with reasons.
     *
     * @return array invalid properties with reasons
     */
    public function listInvalidProperties()
    {
        $invalidProperties = [];

        return $invalidProperties;
    }

    /**
     * Validate all the properties in the model
     * return true if all passed
     *
     * @return bool True if all properties are valid
     */
    public function valid()
    {
        return count($this->listInvalidProperties()) === 0;
    }


    /**
     * Gets uid
     *
     * @return string
     */
    public function getUid()
    {
        return $this->container['uid'];
    }

    /**
     * Sets uid
     *
     * @param string $uid uid
     *
     * @return $this
     */
    public function setUid($uid)
    {
        $this->container['uid'] = $uid;

        return $this;
    }

    /**
     * Gets ta
     *
     * @return int
     */
    public function getTa()
    {
        return $this->container['ta'];
    }

    /**
     * Sets ta
     *
     * @param int $ta ta
     *
     * @return $this
     */
    public function setTa($ta)
    {
        $this->container['ta'] = $ta;

        return $this;
    }

    /**
     * Gets tb
     *
     * @return int
     */
    public function getTb()
    {
        return $this->container['tb'];
    }

    /**
     * Sets tb
     *
     * @param int $tb tb
     *
     * @return $this
     */
    public function setTb($tb)
    {
        $this->container['tb'] = $tb;

        return $this;
    }

    /**
     * Gets tc
     *
     * @return int
     */
    public function getTc()
    {
        return $this->container['tc'];
    }

    /**
     * Sets tc
     *
     * @param int $tc tc
     *
     * @return $this
     */
    public function setTc($tc)
    {
        $this->container['tc'] = $tc;

        return $this;
    }

    /**
     * Gets td
     *
     * @return int
     */
    public function getTd()
    {
        return $this->container['td'];
    }

    /**
     * Sets td
     *
     * @param int $td td
     *
     * @return $this
     */
    public function setTd($td)
    {
        $this->container['td'] = $td;

        return $this;
    }

    /**
     * Gets taa
     *
     * @return int
     */
    public function getTaa()
    {
        return $this->container['taa'];
    }

    /**
     * Sets taa
     *
     * @param int $taa taa
     *
     * @return $this
     */
    public function setTaa($taa)
    {
        $this->container['taa'] = $taa;

        return $this;
    }

    /**
     * Gets tab
     *
     * @return int
     */
    public function getTab()
    {
        return $this->container['tab'];
    }

    /**
     * Sets tab
     *
     * @param int $tab tab
     *
     * @return $this
     */
    public function setTab($tab)
    {
        $this->container['tab'] = $tab;

        return $this;
    }

    /**
     * Gets tac
     *
     * @return int
     */
    public function getTac()
    {
        return $this->container['tac'];
    }

    /**
     * Sets tac
     *
     * @param int $tac tac
     *
     * @return $this
     */
    public function setTac($tac)
    {
        $this->container['tac'] = $tac;

        return $this;
    }

    /**
     * Gets tad
     *
     * @return int
     */
    public function getTad()
    {
        return $this->container['tad'];
    }

    /**
     * Sets tad
     *
     * @param int $tad tad
     *
     * @return $this
     */
    public function setTad($tad)
    {
        $this->container['tad'] = $tad;

        return $this;
    }

    /**
     * Gets tae
     *
     * @return int
     */
    public function getTae()
    {
        return $this->container['tae'];
    }

    /**
     * Sets tae
     *
     * @param int $tae tae
     *
     * @return $this
     */
    public function setTae($tae)
    {
        $this->container['tae'] = $tae;

        return $this;
    }

    /**
     * Gets taf
     *
     * @return int
     */
    public function getTaf()
    {
        return $this->container['taf'];
    }

    /**
     * Sets taf
     *
     * @param int $taf taf
     *
     * @return $this
     */
    public function setTaf($taf)
    {
        $this->container['taf'] = $taf;

        return $this;
    }

    /**
     * Gets hab
     *
     * @return int
     */
    public function getHab()
    {
        return $this->container['hab'];
    }

    /**
     * Sets hab
     *
     * @param int $hab hab
     *
     * @return $this
     */
    public function setHab($hab)
    {
        $this->container['hab'] = $hab;

        return $this;
    }

    /**
     * Gets had
     *
     * @return int
     */
    public function getHad()
    {
        return $this->container['had'];
    }

    /**
     * Sets had
     *
     * @param int $had had
     *
     * @return $this
     */
    public function setHad($had)
    {
        $this->container['had'] = $had;

        return $this;
    }

    /**
     * Gets vab
     *
     * @return int
     */
    public function getVab()
    {
        return $this->container['vab'];
    }

    /**
     * Sets vab
     *
     * @param int $vab vab
     *
     * @return $this
     */
    public function setVab($vab)
    {
        $this->container['vab'] = $vab;

        return $this;
    }

    /**
     * Gets vad
     *
     * @return int
     */
    public function getVad()
    {
        return $this->container['vad'];
    }

    /**
     * Sets vad
     *
     * @param int $vad vad
     *
     * @return $this
     */
    public function setVad($vad)
    {
        $this->container['vad'] = $vad;

        return $this;
    }

    /**
     * Gets aib
     *
     * @return int
     */
    public function getAib()
    {
        return $this->container['aib'];
    }

    /**
     * Sets aib
     *
     * @param int $aib aib
     *
     * @return $this
     */
    public function setAib($aib)
    {
        $this->container['aib'] = $aib;

        return $this;
    }

    /**
     * Gets ts
     *
     * @return int
     */
    public function getTs()
    {
        return $this->container['ts'];
    }

    /**
     * Sets ts
     *
     * @param int $ts ts
     *
     * @return $this
     */
    public function setTs($ts)
    {
        $this->container['ts'] = $ts;

        return $this;
    }

    /**
     * Gets total
     *
     * @return int
     */
    public function getTotal()
    {
        return $this->container['total'];
    }

    /**
     * Sets total
     *
     * @param int $total total
     *
     * @return $this
     */
    public function setTotal($total)
    {
        $this->container['total'] = $total;

        return $this;
    }

    /**
     * Gets error_code
     *
     * @return string
     */
    public function getErrorCode()
    {
        return $this->container['error_code'];
    }

    /**
     * Sets error_code
     *
     * @param string $error_code error_code
     *
     * @return $this
     */
    public function setErrorCode($error_code)
    {
        $this->container['error_code'] = $error_code;

        return $this;
    }

    /**
     * Gets error_desc
     *
     * @return string
     */
    public function getErrorDesc()
    {
        return $this->container['error_desc'];
    }

    /**
     * Sets error_desc
     *
     * @param string $error_desc error_desc
     *
     * @return $this
     */
    public function setErrorDesc($error_desc)
    {
        $this->container['error_desc'] = $error_desc;

        return $this;
    }
    /**
     * Returns true if offset exists. False otherwise.
     *
     * @param integer $offset Offset
     *
     * @return boolean
     */
    public function offsetExists($offset)
    {
        return isset($this->container[$offset]);
    }

    /**
     * Gets offset.
     *
     * @param integer $offset Offset
     *
     * @return mixed
     */
    public function offsetGet($offset)
    {
        return isset($this->container[$offset]) ? $this->container[$offset] : null;
    }

    /**
     * Sets value based on offset.
     *
     * @param integer $offset Offset
     * @param mixed   $value  Value to be set
     *
     * @return void
     */
    public function offsetSet($offset, $value)
    {
        if (is_null($offset)) {
            $this->container[] = $value;
        } else {
            $this->container[$offset] = $value;
        }
    }

    /**
     * Unsets offset.
     *
     * @param integer $offset Offset
     *
     * @return void
     */
    public function offsetUnset($offset)
    {
        unset($this->container[$offset]);
    }

    /**
     * Gets the string presentation of the object
     *
     * @return string
     */
    public function __toString()
    {
        if (defined('JSON_PRETTY_PRINT')) { // use JSON pretty print
            return json_encode(
                ObjectSerializer::sanitizeForSerialization($this),
                JSON_PRETTY_PRINT
            );
        }

        return json_encode(ObjectSerializer::sanitizeForSerialization($this));
    }
}
