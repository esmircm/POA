<?php

/**
 * This is the model class for table "pais".
 *
 * The followings are the available columns in table 'pais':
 * @property integer $id_pais
 * @property string $abreviatura
 * @property string $cod_pais
 * @property string $nombre
 * @property string $moneda
 * @property string $moneda_sing
 * @property string $moneda_plur
 * @property string $simbolo
 * @property string $fraccion
 * @property integer $id_region_continente
 *
 * The followings are the available model relations:
 * @property Personal[] $personals
 * @property Estudio[] $estudios
 * @property Regioncontinente $idRegionContinente
 * @property Estado[] $estados
 * @property Elegibleestudio[] $elegibleestudios
 */
class Pais extends CActiveRecord {

        public $id_pais1;
    
    
    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'pais';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_pais, cod_pais, nombre', 'required'),
            array('id_pais, id_pais1, id_region_continente', 'numerical', 'integerOnly' => true),
            array('abreviatura, cod_pais', 'length', 'max' => 3),
            array('nombre', 'length', 'max' => 40),
            array('moneda, moneda_sing, moneda_plur', 'length', 'max' => 30),
            array('simbolo', 'length', 'max' => 6),
            array('fraccion', 'length', 'max' => 20),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_pais, id_pais1, abreviatura, cod_pais, nombre, moneda, moneda_sing, moneda_plur, simbolo, fraccion, id_region_continente', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'personals' => array(self::HAS_MANY, 'Personal', 'id_pais_nacionalidad'),
            'estudios' => array(self::HAS_MANY, 'Estudio', 'id_pais'),
            'idRegionContinente' => array(self::BELONGS_TO, 'Regioncontinente', 'id_region_continente'),
            'estados' => array(self::HAS_MANY, 'Estado', 'id_pais'),
            'elegibleestudios' => array(self::HAS_MANY, 'Elegibleestudio', 'id_pais'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_pais' => 'Pais',
            'abreviatura' => 'Abreviatura',
            'cod_pais' => 'Cod Pais',
            'nombre' => 'Nombre',
            'moneda' => 'Moneda',
            'moneda_sing' => 'Moneda Sing',
            'moneda_plur' => 'Moneda Plur',
            'simbolo' => 'Simbolo',
            'fraccion' => 'Fraccion',
            'id_region_continente' => 'Id Region Continente',
            'id_pais1'=>'Pais',
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

        $criteria->compare('id_pais', $this->id_pais);
//        $criteria->compare('id_pais1', $this->id_pais);
        $criteria->compare('abreviatura', $this->abreviatura, true);
        $criteria->compare('cod_pais', $this->cod_pais, true);
        $criteria->compare('nombre', $this->nombre, true);
        $criteria->compare('moneda', $this->moneda, true);
        $criteria->compare('moneda_sing', $this->moneda_sing, true);
        $criteria->compare('moneda_plur', $this->moneda_plur, true);
        $criteria->compare('simbolo', $this->simbolo, true);
        $criteria->compare('fraccion', $this->fraccion, true);
        $criteria->compare('id_region_continente', $this->id_region_continente);

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
     * @return Pais the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
