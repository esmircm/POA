<?php

/**
 * This is the model class for table "ciudad".
 *
 * The followings are the available columns in table 'ciudad':
 * @property integer $id_ciudad
 * @property string $abreviatura
 * @property string $cod_ciudad
 * @property integer $id_estado
 * @property string $nombre
 * @property double $multiplicador
 * @property double $fluctuacion
 *
 * The followings are the available model relations:
 * @property Organismo[] $organismos
 * @property Personal[] $personals
 * @property Personal[] $personals1
 * @property Educacion[] $educacions
 * @property Estado $idEstado
 * @property Lugarpago[] $lugarpagos
 * @property Sede[] $sedes
 * @property Detalletabuladormre[] $detalletabuladormres
 * @property Establecimientosalud[] $establecimientosaluds
 * @property Proyecto[] $proyectos
 * @property Cuentabanco[] $cuentabancos
 * @property Sedediplomatica[] $sedediplomaticas
 */
class Ciudad extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public $id_ciudad_residencia;
    public $id_ciudad_nacimiento;
    public $id_ciudad;
    

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'ciudad';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_ciudad, cod_ciudad, id_estado, nombre', 'required'),
            array('id_ciudad, id_ciudad_residencia, id_ciudad_nacimiento, id_estado', 'numerical', 'integerOnly' => true),
            array('multiplicador, fluctuacion', 'numerical'),
            array('abreviatura, cod_ciudad', 'length', 'max' => 3),
            array('nombre', 'length', 'max' => 40),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_ciudad, id_ciudad_nacimiento, abreviatura, cod_ciudad, id_estado, nombre, multiplicador, fluctuacion', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'idCiudadNacimiento' => array(self::BELONGS_TO, 'Ciudad', 'id_ciudad_nacimiento'),
            'organismos' => array(self::HAS_MANY, 'Organismo', 'id_ciudad'),
            'organismos' => array(self::HAS_MANY, 'Organismo', 'id_ciudad'),
            'personals' => array(self::HAS_MANY, 'Personal', 'id_ciudad_residencia'),
            'idCiudadResidencia' => array(self::BELONGS_TO, 'Ciudad', 'id_ciudad_residencia'),
            'idCiudadResidencia' => array(self::BELONGS_TO, 'Ciudad', 'id_ciudad_residencia'),
            'personals1' => array(self::HAS_MANY, 'Personal', 'id_ciudad_nacimiento'),
            'educacions' => array(self::HAS_MANY, 'Educacion', 'id_ciudad'),
            'idEstado' => array(self::BELONGS_TO, 'Estado', 'id_estado'),
            'lugarpagos' => array(self::HAS_MANY, 'Lugarpago', 'id_ciudad'),
            'sedes' => array(self::HAS_MANY, 'Sede', 'id_ciudad'),
            'detalletabuladormres' => array(self::HAS_MANY, 'Detalletabuladormre', 'id_ciudad'),
            'establecimientosaluds' => array(self::HAS_MANY, 'Establecimientosalud', 'id_ciudad'),
            'proyectos' => array(self::HAS_MANY, 'Proyecto', 'id_ciudad'),
            'cuentabancos' => array(self::HAS_MANY, 'Cuentabanco', 'id_ciudad'),
            'sedediplomaticas' => array(self::HAS_MANY, 'Sedediplomatica', 'id_ciudad'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_ciudad_nacimiento' => 'Ciudad Nacimiento',
            'id_ciudad_residencia' => 'Ciudad Residencia',
            'id_ciudad' => 'Ciudad',
            'abreviatura' => 'Abreviatura',
            'cod_ciudad' => 'Cod Ciudad',
            'id_estado' => 'Id Estado',
            'id_estado1' => 'Id Estado',
            'nombre' => 'Nombre',
            'multiplicador' => 'Multiplicador',
            'fluctuacion' => 'Fluctuacion',
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
        $criteria->compare('id_ciudad_nacimiento', $this->id_ciudad_nacimiento);
        $criteria->compare('id_ciudad_residencia', $this->id_ciudad_residencia);
        $criteria->compare('id_ciudad', $this->id_ciudad);
        $criteria->compare('abreviatura', $this->abreviatura, true);
        $criteria->compare('cod_ciudad', $this->cod_ciudad, true);
        $criteria->compare('id_estado', $this->id_estado);
        $criteria->compare('nombre', $this->nombre, true);
        $criteria->compare('multiplicador', $this->multiplicador);
        $criteria->compare('fluctuacion', $this->fluctuacion);

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
     * @return Ciudad the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
