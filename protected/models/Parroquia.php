<?php

/**
 * This is the model class for table "parroquia".
 *
 * The followings are the available columns in table 'parroquia':
 * @property integer $id_parroquia
 * @property string $abreviatura
 * @property string $cod_parroquia
 * @property integer $id_municipio
 * @property string $nombre
 *
 * The followings are the available model relations:
 * @property Personal[] $personals
 * @property Municipio $idMunicipio
 */
class Parroquia extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'parroquia';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_parroquia, cod_parroquia, id_municipio, nombre', 'required'),
            array('id_parroquia, id_municipio', 'numerical', 'integerOnly' => true),
            array('abreviatura', 'length', 'max' => 3),
            array('cod_parroquia', 'length', 'max' => 2),
            array('nombre', 'length', 'max' => 40),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_parroquia, abreviatura, cod_parroquia, id_municipio, nombre', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'personals' => array(self::HAS_MANY, 'Personal', 'id_parroquia'),
            'idMunicipio' => array(self::BELONGS_TO, 'Municipio', 'id_municipio'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_parroquia' => 'Id Parroquia',
            'abreviatura' => 'Abreviatura',
            'cod_parroquia' => 'Cod Parroquia',
            'id_municipio' => 'Id Municipio',
            'nombre' => 'Nombre',
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

        $criteria->compare('id_parroquia', $this->id_parroquia);
        $criteria->compare('abreviatura', $this->abreviatura, true);
        $criteria->compare('cod_parroquia', $this->cod_parroquia, true);
        $criteria->compare('id_municipio', $this->id_municipio);
        $criteria->compare('nombre', $this->nombre, true);

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
     * @return Parroquia the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
