<?php

namespace App\Services\lib\Model;

use App\Services\lib\ObjectSerializer;


class ItemDto implements ModelInterface, \ArrayAccess
{
    const DISCRIMINATOR = null;

    /**
      * The original name of the model.
      *
      * @var string
      */
    protected static $swaggerModelName = 'ItemDto';

    /**
      * Array of property to type mappings. Used for (de)serialization
      *
      * @var string[]
      */
    protected static $swaggerTypes = [
        'code' => 'string',
'name' => 'string',
'price' => 'int',
'quantity' => 'double',
'tax_group' => 'App\Services\lib\Model\TaxGroupTypeEnum',
'tax_specific' => 'int',
'original_price' => 'double',
'price_modification' => 'string'    ];

    /**
      * Array of property to format mappings. Used for (de)serialization
      *
      * @var string[]
      */
    protected static $swaggerFormats = [
        'code' => null,
'name' => null,
'price' => 'int64',
'quantity' => 'double',
'tax_group' => null,
'tax_specific' => 'int64',
'original_price' => 'double',
'price_modification' => null    ];

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
        'code' => 'code',
        'name' => 'name',
        'price' => 'price',
        'quantity' => 'quantity',
        'tax_group' => 'taxGroup',
        'tax_specific' => 'taxSpecific',
        'original_price' => 'originalPrice',
        'price_modification' => 'priceModification'    
    ];

    /**
     * Array of attributes to setter functions (for deserialization of responses)
     *
     * @var string[]
     */
    protected static $setters = [
        'code' => 'setCode',
        'name' => 'setName',
        'price' => 'setPrice',
        'quantity' => 'setQuantity',
        'tax_group' => 'setTaxGroup',
        'tax_specific' => 'setTaxSpecific',
        'original_price' => 'setOriginalPrice',
        'price_modification' => 'setPriceModification'    
    ];

    /**
     * Array of attributes to getter functions (for serialization of requests)
     *
     * @var string[]
     */
    protected static $getters = [
        'code' => 'getCode',
        'name' => 'getName',
        'price' => 'getPrice',
        'quantity' => 'getQuantity',
        'tax_group' => 'getTaxGroup',
        'tax_specific' => 'getTaxSpecific',
        'original_price' => 'getOriginalPrice',
        'price_modification' => 'getPriceModification'   
    ];

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
        $this->container['code'] = isset($data['code']) ? $data['code'] : null;
        $this->container['name'] = isset($data['name']) ? $data['name'] : null;
        $this->container['price'] = isset($data['price']) ? $data['price'] : null;
        $this->container['quantity'] = isset($data['quantity']) ? $data['quantity'] : null;
        $this->container['tax_group'] = isset($data['tax_group']) ? $data['tax_group'] : null;
        $this->container['tax_specific'] = isset($data['tax_specific']) ? $data['tax_specific'] : null;
        $this->container['original_price'] = isset($data['original_price']) ? $data['original_price'] : null;
        $this->container['price_modification'] = isset($data['price_modification']) ? $data['price_modification'] : null;
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
     * Gets code
     *
     * @return string
     */
    public function getCode()
    {
        return $this->container['code'];
    }

    /**
     * Sets code
     *
     * @param string $code code
     *
     * @return $this
     */
    public function setCode($code)
    {
        $this->container['code'] = $code;

        return $this;
    }

    /**
     * Gets name
     *
     * @return string
     */
    public function getName()
    {
        return $this->container['name'];
    }

    /**
     * Sets name
     *
     * @param string $name name
     *
     * @return $this
     */
    public function setName($name)
    {
        $this->container['name'] = $name;

        return $this;
    }

    /**
     * Gets price
     *
     * @return int
     */
    public function getPrice()
    {
        return $this->container['price'];
    }

    /**
     * Sets price
     *
     * @param int $price price
     *
     * @return $this
     */
    public function setPrice($price)
    {
        $this->container['price'] = $price;

        return $this;
    }

    /**
     * Gets quantity
     *
     * @return double
     */
    public function getQuantity()
    {
        return $this->container['quantity'];
    }

    /**
     * Sets quantity
     *
     * @param double $quantity quantity
     *
     * @return $this
     */
    public function setQuantity($quantity)
    {
        $this->container['quantity'] = $quantity;

        return $this;
    }

    /**
     * Gets tax_group
     *
     * @return App\Services\lib\Model\TaxGroupTypeEnum
     */
    public function getTaxGroup()
    {
        return $this->container['tax_group'];
    }

    /**
     * Sets tax_group
     *
     * @param App\Services\lib\Model\TaxGroupTypeEnum $tax_group tax_group
     *
     * @return $this
     */
    public function setTaxGroup($tax_group)
    {
        $this->container['tax_group'] = $tax_group;

        return $this;
    }

    /**
     * Gets tax_specific
     *
     * @return int
     */
    public function getTaxSpecific()
    {
        return $this->container['tax_specific'];
    }

    /**
     * Sets tax_specific
     *
     * @param int $tax_specific tax_specific
     *
     * @return $this
     */
    public function setTaxSpecific($tax_specific)
    {
        $this->container['tax_specific'] = $tax_specific;

        return $this;
    }

    /**
     * Gets original_price
     *
     * @return double
     */
    public function getOriginalPrice()
    {
        return $this->container['original_price'];
    }

    /**
     * Sets original_price
     *
     * @param double $original_price original_price
     *
     * @return $this
     */
    public function setOriginalPrice($original_price)
    {
        $this->container['original_price'] = $original_price;

        return $this;
    }

    /**
     * Gets price_modification
     *
     * @return string
     */
    public function getPriceModification()
    {
        return $this->container['price_modification'];
    }

    /**
     * Sets price_modification
     *
     * @param string $price_modification price_modification
     *
     * @return $this
     */
    public function setPriceModification($price_modification)
    {
        $this->container['price_modification'] = $price_modification;

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
