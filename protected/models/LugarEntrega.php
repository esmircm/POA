<?php

/**
 * This is the model class for table "requisicion.lugar_entrega".
 *
 * The followings are the available columns in table 'requisicion.lugar_entrega':
 * @property integer $id_lugar_entrega
 * @property integer $fk_datos_requisicion
 * @property string $dependencia
 * @property string $direccion
 * @property boolean $es_almacen
 * @property string $fecha_estimada_requerida
 * @property boolean $es_activo
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 * @property integer $fk_estatus
 *
 * The followings are the available model relations:
 * @property DatosRequisicion $fkDatosRequisicion
 */
class LugarEntrega extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'requisicion.lugar_entrega';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('dependencia, direccion, fecha_estimada_requerida, es_activo, created_date, modified_date', 'required'),
            array('fk_datos_requisicion, created_by, modified_by, fk_estatus', 'numerical', 'integerOnly' => true),
            array('dependencia', 'length', 'max' => 100),
            array('direccion', 'length', 'max' => 150),
            array('es_almacen, fecha_estimada_requerida', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_lugar_entrega, fk_datos_requisicion, dependencia, direccion, es_almacen, fecha_estimada_requerida, es_activo, created_by, created_date, modified_by, modified_date, fk_estatus', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'fkDatosRequisicion' => array(self::BELONGS_TO, 'DatosRequisicion', 'fk_datos_requisicion'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_lugar_entrega' => 'Id Lugar Entrega',
            'fk_datos_requisicion' => 'Fk Datos Requisicion',
            'dependencia' => 'Dependencia',
            'direccion' => 'Direccion',
            'es_almacen' => 'Es Almacen',
            'fecha_estimada_requerida' => 'Fecha Estimada Requerida',
            'es_activo' => 'Es Activo',
            'created_by' => 'Created By',
            'created_date' => 'Created Date',
            'modified_by' => 'Modified By',
            'modified_date' => 'Modified Date',
            'fk_estatus' => 'Fk Estatus',
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

        $criteria->compare('id_lugar_entrega', $this->id_lugar_entrega);
        $criteria->compare('fk_datos_requisicion', $this->fk_datos_requisicion);
        $criteria->compare('dependencia', $this->dependencia, true);
        $criteria->compare('direccion', $this->direccion, true);
        $criteria->compare('es_almacen', $this->es_almacen);
        $criteria->compare('fecha_estimada_requerida', $this->fecha_estimada_requerida, true);
        $criteria->compare('es_activo', $this->es_activo);
        $criteria->compare('created_by', $this->created_by);
        $criteria->compare('created_date', $this->created_date, true);
        $criteria->compare('modified_by', $this->modified_by);
        $criteria->compare('modified_date', $this->modified_date, true);
        $criteria->compare('fk_estatus', $this->fk_estatus);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return LugarEntrega the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
