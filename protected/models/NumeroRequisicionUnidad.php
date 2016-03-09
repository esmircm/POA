<?php

/**
 * This is the model class for table "requisicion.numero_requisicion_unidad".
 *
 * The followings are the available columns in table 'requisicion.numero_requisicion_unidad':
 * @property integer $id_n_requisicion
 * @property integer $fk_datos_requisicion
 * @property string $numero
 * @property boolean $es_activo
 * @property integer $fk_estatus
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 *
 * The followings are the available model relations:
 * @property DatosRequisicion $fkDatosRequisicion
 */
class NumeroRequisicionUnidad extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'requisicion.numero_requisicion_unidad';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('fk_datos_requisicion, fk_estatus, created_by, modified_by', 'numerical', 'integerOnly' => true),
            array('numero', 'length', 'max' => 14),
            array('es_activo, created_date, modified_date', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_n_requisicion, fk_datos_requisicion, numero, es_activo, fk_estatus, created_by, created_date, modified_by, modified_date', 'safe', 'on' => 'search'),
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
            'id_n_requisicion' => 'Id N Requisicion',
            'fk_datos_requisicion' => 'Fk Datos Requisicion',
            'numero' => 'N° Original',
            'es_activo' => 'Es Activo',
            'fk_estatus' => 'Fk Estatus',
            'created_by' => 'Created By',
            'created_date' => 'Created Date',
            'modified_by' => 'Modified By',
            'modified_date' => 'Modified Date',
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

        $criteria->compare('id_n_requisicion', $this->id_n_requisicion);
        $criteria->compare('fk_datos_requisicion', $this->fk_datos_requisicion);
        $criteria->compare('numero', $this->numero, true);
        $criteria->compare('es_activo', $this->es_activo);
        $criteria->compare('fk_estatus', $this->fk_estatus);
        $criteria->compare('created_by', $this->created_by);
        $criteria->compare('created_date', $this->created_date, true);
        $criteria->compare('modified_by', $this->modified_by);
        $criteria->compare('modified_date', $this->modified_date, true);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return NumeroRequisicionUnidad the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
