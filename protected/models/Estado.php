<?php

/**
 * This is the model class for table "estado".
 *
 * The followings are the available columns in table 'estado':
 * @property integer $id_estado
 * @property string $abreviatura
 * @property string $cod_estado
 * @property string $nombre
 * @property integer $id_pais
 *
 * The followings are the available model relations:
 * @property Ciudad[] $ciudads
 * @property Municipio[] $municipios
 * @property Pais $idPais
 * @property Entidadeducativa[] $entidadeducativas
 */
class Estado extends CActiveRecord {

    public $id_estado1;
    
    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'estado';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('cod_estado, nombre, id_pais', 'required'),
            array('id_estado, id_estado1, id_pais', 'numerical', 'integerOnly' => true),
            array('abreviatura', 'length', 'max' => 3),
            array('cod_estado', 'length', 'max' => 2),
            array('nombre', 'length', 'max' => 40),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_estado, abreviatura, id_estado1, cod_estado, nombre, id_pais', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'ciudads' => array(self::HAS_MANY, 'Ciudad', 'id_estado'),
            'municipios' => array(self::HAS_MANY, 'Municipio', 'id_estado'),
            'idPais' => array(self::BELONGS_TO, 'Pais', 'id_pais'),
            'entidadeducativas' => array(self::HAS_MANY, 'Entidadeducativa', 'id_estado'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_estado' => 'Estado',
            'abreviatura' => 'Abreviatura',
            'cod_estado' => 'Cod Estado',
            'nombre' => 'Nombre',
            'id_pais' => 'Id Pais',
            'id_estado1'=> 'Estado',
        );
    }

    /**
     * Retrieves a list of models based on the current search/filter conditions.
     *
     * Typical usecase:
     * - Initialize the model fields with values from filter form.
     * - Execute this method to get CActiveDataProvider instance which will filter
     * models according to data in model fields.
     * - Pass data provider to CGridView, CListView or any similar widget.
     *
     * @return CActiveDataProvider the data provider that can return the models
     * based on the search/filter conditions.
     */
    public function search() {
        // @todo Please modify the following code to remove attributes that should not be searched.

        $criteria = new CDbCriteria;

        $criteria->compare('id_estado', $this->id_estado);
//        $criteria->compare('id_estado1', $this->id_estado);
        $criteria->compare('abreviatura', $this->abreviatura, true);
        $criteria->compare('cod_estado', $this->cod_estado, true);
        $criteria->compare('nombre', $this->nombre, true);
        $criteria->compare('id_pais', $this->id_pais);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    /**
     * @return CDbConnection the database connection used for this class
     */
    public function getDbConnection() {
        return Yii::app()->db2;
    }

    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return Estado the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
