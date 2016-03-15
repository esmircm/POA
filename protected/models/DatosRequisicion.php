<?php

/**
 * This is the model class for table "requisicion.datos_requisicion".
 *
 * The followings are the available columns in table 'requisicion.datos_requisicion':
 * @property integer $id_datos_requisicion
 * @property integer $fk_tipo_requisicion
 * @property integer $anio_requisicion
 * @property integer $fk_unidad_ejecutora
 * @property string $ubicacion_geografica
 * @property integer $fk_parroquia
 * @property string $ciudad
 * @property integer $fk_fuente_financia
 * @property boolean $es_anulacion
 * @property boolean $es_activo
 * @property integer $fk_estatus
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 */
class DatosRequisicion extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'requisicion.datos_requisicion';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('fk_tipo_requisicion, anio_requisicion, fk_unidad_ejecutora, fk_parroquia, ubicacion_geografica, ciudad', 'required'),
            array('fk_tipo_requisicion, anio_requisicion, fk_unidad_ejecutora, fk_parroquia, fk_fuente_financia, fk_estatus, created_by, modified_by', 'numerical', 'integerOnly' => true),
            array('ubicacion_geografica', 'length', 'max' => 150),
            array('ciudad, es_anulacion, es_activo, created_date, modified_date', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_datos_requisicion, fk_tipo_requisicion, anio_requisicion, fk_unidad_ejecutora, ubicacion_geografica, fk_parroquia, ciudad, fk_fuente_financia, es_anulacion, es_activo, fk_estatus, created_by, created_date, modified_by, modified_date', 'safe', 'on' => 'search'),
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
            'id_datos_requisicion' => 'Id Datos Requisicion',
            'fk_tipo_requisicion' => 'Tipo de Requisicion',
            'anio_requisicion' => 'Año',
            'fk_unidad_ejecutora' => 'Unidad Ejecutora',
            'ubicacion_geografica' => 'Ubicacion Geografica',
            'fk_parroquia' => 'Parroquia',
            'ciudad' => 'Ciudad',
            'fk_fuente_financia' => 'Fuente Financiamiento',
            'es_anulacion' => '',
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

        $criteria->compare('id_datos_requisicion', $this->id_datos_requisicion);
        $criteria->compare('fk_tipo_requisicion', $this->fk_tipo_requisicion);
        $criteria->compare('anio_requisicion', $this->anio_requisicion);
        $criteria->compare('fk_unidad_ejecutora', $this->fk_unidad_ejecutora);
        $criteria->compare('ubicacion_geografica', $this->ubicacion_geografica, true);
        $criteria->compare('fk_parroquia', $this->fk_parroquia);
        $criteria->compare('ciudad', $this->ciudad, true);
        $criteria->compare('fk_fuente_financia', $this->fk_fuente_financia);
        $criteria->compare('es_anulacion', $this->es_anulacion);
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
     * @return DatosRequisicion the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
