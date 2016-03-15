<?php

/**
 * This is the model class for table "carrera".
 *
 * The followings are the available columns in table 'carrera':
 * @property integer $id_carrera
 * @property string $cod_carrera
 * @property string $nombre
 *
 * The followings are the available model relations:
 * @property Educacion[] $educacions
 * @property Elegibleactividaddocente[] $elegibleactividaddocentes
 * @property Carreraarea[] $carreraareas
 * @property Actividaddocente[] $actividaddocentes
 */
class Carrera extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'carrera';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_carrera, cod_carrera, nombre', 'required'),
            array('id_carrera', 'numerical', 'integerOnly' => true),
            array('cod_carrera', 'length', 'max' => 3),
            array('nombre', 'length', 'max' => 90),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_carrera, cod_carrera, nombre', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'educacions' => array(self::HAS_MANY, 'Educacion', 'id_carrera'),
            'elegibleactividaddocentes' => array(self::HAS_MANY, 'Elegibleactividaddocente', 'id_carrera'),
            'carreraareas' => array(self::HAS_MANY, 'Carreraarea', 'id_carrera'),
            'actividaddocentes' => array(self::HAS_MANY, 'Actividaddocente', 'id_carrera'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_carrera' => 'Id Carrera',
            'cod_carrera' => 'Cod Carrera',
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

        $criteria->compare('id_carrera', $this->id_carrera);
        $criteria->compare('cod_carrera', $this->cod_carrera, true);
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

//            funcion que permite hacer la busqueda por id de la carrera
    public function FindBuscarCarreraByPadreSelect($IdCarrera) {
        $criteria = new CDbCriteria;
        $data = CHtml::listData(self::model()->findAll($criteria), 'id_carrera', 'nombre');
        return $data;
    }

    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return Carrera the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
