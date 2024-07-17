<?php

namespace App\Services\lib\Model;


class InfoResponseDto implements ModelInterface, \ArrayAccess
{
    const DISCRIMINATOR = null;

    /**
      * The original name of the model.
      *
      * @var string
      */
    protected static $swaggerModelName = 'InfoResponseDto';

    /**
      * Array of property to type mappings. Used for (de)serialization
      *
      * @var string[]
      */
    protected static $swaggerTypes = [
        'status' => 'bool',
'version' => 'string',
'ifu' => 'string',
'nim' => 'string',
'token_valid' => '\DateTime',
'server_date_time' => '\DateTime',
'emcf_list' => 'App\Services\lib\Model\EmcfInfoDto[]'    ];

    /**
      * Array of property to format mappings. Used for (de)serialization
      *
      * @var string[]
      */
    protected static $swaggerFormats = [
        'status' => null,
'version' => null,
'ifu' => null,
'nim' => null,
'token_valid' => 'date-time',
'server_date_time' => 'date-time',
'emcf_list' => null    ];

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
        'status' => 'status',
'version' => 'version',
'ifu' => 'ifu',
'nim' => 'nim',
'token_valid' => 'tokenValid',
'server_date_time' => 'serverDateTime',
'emcf_list' => 'emcfList'    ];

    /**
     * Array of attributes to setter functions (for deserialization of responses)
     *
     * @var string[]
     */
    protected static $setters = [
        'status' => 'setStatus',
'version' => 'setVersion',
'ifu' => 'setIfu',
'nim' => 'setNim',
'token_valid' => 'setTokenValid',
'server_date_time' => 'setServerDateTime',
'emcf_list' => 'setEmcfList'    ];

    /**
     * Array of attributes to getter functions (for serialization of requests)
     *
     * @var string[]
     */
    protected static $getters = [
        'status' => 'getStatus',
'version' => 'getVersion',
'ifu' => 'getIfu',
'nim' => 'getNim',
'token_valid' => 'getTokenValid',
'server_date_time' => 'getServerDateTime',
'emcf_list' => 'getEmcfList'    ];

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
        $this->container['status'] = isset($data['status']) ? $data['status'] : null;
        $this->container['version'] = isset($data['version']) ? $data['version'] : null;
        $this->container['ifu'] = isset($data['ifu']) ? $data['ifu'] : null;
        $this->container['nim'] = isset($data['nim']) ? $data['nim'] : null;
        $this->container['token_valid'] = isset($data['token_valid']) ? $data['token_valid'] : null;
        $this->container['server_date_time'] = isset($data['server_date_time']) ? $data['server_date_time'] : null;
        $this->container['emcf_list'] = isset($data['emcf_list']) ? $data['emcf_list'] : null;
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
     * Gets status
     *
     * @return bool
     */
    public function getStatus()
    {
        return $this->container['status'];
    }

    /**
     * Sets status
     *
     * @param bool $status status
     *
     * @return $this
     */
    public function setStatus($status)
    {
        $this->container['status'] = $status;

        return $this;
    }

    /**
     * Gets version
     *
     * @return string
     */
    public function getVersion()
    {
        return $this->container['version'];
    }

    /**
     * Sets version
     *
     * @param string $version version
     *
     * @return $this
     */
    public function setVersion($version)
    {
        $this->container['version'] = $version;

        return $this;
    }

    /**
     * Gets ifu
     *
     * @return string
     */
    public function getIfu()
    {
        return $this->container['ifu'];
    }

    /**
     * Sets ifu
     *
     * @param string $ifu ifu
     *
     * @return $this
     */
    public function setIfu($ifu)
    {
        $this->container['ifu'] = $ifu;

        return $this;
    }

    /**
     * Gets nim
     *
     * @return string
     */
    public function getNim()
    {
        return $this->container['nim'];
    }

    /**
     * Sets nim
     *
     * @param string $nim nim
     *
     * @return $this
     */
    public function setNim($nim)
    {
        $this->container['nim'] = $nim;

        return $this;
    }

    /**
     * Gets token_valid
     *
     * @return \DateTime
     */
    public function getTokenValid()
    {
        return $this->container['token_valid'];
    }

    /**
     * Sets token_valid
     *
     * @param \DateTime $token_valid token_valid
     *
     * @return $this
     */
    public function setTokenValid($token_valid)
    {
        $this->container['token_valid'] = $token_valid;

        return $this;
    }

    /**
     * Gets server_date_time
     *
     * @return \DateTime
     */
    public function getServerDateTime()
    {
        return $this->container['server_date_time'];
    }

    /**
     * Sets server_date_time
     *
     * @param \DateTime $server_date_time server_date_time
     *
     * @return $this
     */
    public function setServerDateTime($server_date_time)
    {
        $this->container['server_date_time'] = $server_date_time;

        return $this;
    }

    /**
     * Gets emcf_list
     *
     * @return App\Services\lib\Model\EmcfInfoDto[]
     */
    public function getEmcfList()
    {
        return $this->container['emcf_list'];
    }

    /**
     * Sets emcf_list
     *
     * @param App\Services\lib\Model\EmcfInfoDto[] $emcf_list emcf_list
     *
     * @return $this
     */
    public function setEmcfList($emcf_list)
    {
        $this->container['emcf_list'] = $emcf_list;

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
