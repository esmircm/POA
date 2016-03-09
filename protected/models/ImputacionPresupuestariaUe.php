<?php

/**
 * This is the model class for table "requisicion.imputacion_presupuestaria_ue".
 *
 * The followings are the available columns in table 'requisicion.imputacion_presupuestaria_ue':
 * @property integer $id_imputacion_presupuestaria
 * @property integer $fk_datos_requisicion
 * @property integer $fk_unidad_ejecutora
 * @property integer $fk_proyecto
 * @property integer $fk_accion_especifica
 * @property integer $fk_clasificacion_presupuestaria
 * @property string $descripcion
 * @property integer $fk_unidad_medida
 * @property integer $cantidad
 * @property boolean $es_activo
 * @property integer $fk_estatus
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 */
class ImputacionPresupuestariaUe extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'requisicion.imputacion_presupuestaria_ue';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('fk_datos_requisicion, fk_unidad_ejecutora, fk_proyecto, fk_accion_especifica, fk_clasificacion_presupuestaria, fk_unidad_medida, cantidad, fk_estatus, created_by, modified_by', 'numerical', 'integerOnly' => true),
            array('descripcion, es_activo, created_date, modified_date', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_imputacion_presupuestaria, fk_datos_requisicion, fk_unidad_ejecutora, fk_proyecto, fk_accion_especifica, fk_clasificacion_presupuestaria, descripcion, fk_unidad_medida, cantidad, es_activo, fk_estatus, created_by, created_date, modified_by, modified_date', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_imputacion_presupuestaria' => 'Id Imputacion Presupuestaria',
            'fk_datos_requisicion' => 'Datos Requisicion',
            'fk_unidad_ejecutora' => 'UE',
            'fk_proyecto' => 'PY',
            'fk_accion_especifica' => 'AE',
            'fk_clasificacion_presupuestaria' => 'Clasificacion Presupuestaria',
            'descripcion' => 'Descripcion',
            'fk_unidad_medida' => 'Unidad Medida',
            'cantidad' => 'Cantidad',
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

        $criteria->compare('id_imputacion_presupuestaria', $this->id_imputacion_presupuestaria);
        $criteria->compare('fk_datos_requisicion', $this->fk_datos_requisicion);
        $criteria->compare('fk_unidad_ejecutora', $this->fk_unidad_ejecutora);
        $criteria->compare('fk_proyecto', $this->fk_proyecto);
        $criteria->compare('fk_accion_especifica', $this->fk_accion_especifica);
        $criteria->compare('fk_clasificacion_presupuestaria', $this->fk_clasificacion_presupuestaria);
        $criteria->compare('descripcion', $this->descripcion, true);
        $criteria->compare('fk_unidad_medida', $this->fk_unidad_medida);
        $criteria->compare('cantidad', $this->cantidad);
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
     * @return ImputacionPresupuestariaUe the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
