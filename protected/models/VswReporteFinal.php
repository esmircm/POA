<?php

/**
 * This is the model class for table "evaluacion.vsw_reporte_final".
 *
 * The followings are the available columns in table 'evaluacion.vsw_reporte_final':
 * @property integer $id_persona_evaluado
 * @property string $nacionalidad
 * @property integer $cedula
 * @property string $apellidos
 * @property string $nombres
 * @property string $descripcion_cargo
 * @property string $activo
 * @property integer $cod_dependencia_evaluado
 * @property string $dependencia
 * @property string $tipo_cargo
 * @property string $fk_tipo_clase
 * @property integer $id_evaluacion
 * @property string $fecha_creacion_evaluacion
 * @property integer $id_persona
 * @property integer $cod_dependencia_evaluador
 * @property string $dep_evaluador
 * @property integer $fk_estatus_evaluacion
 * @property string $estatus
 * @property string $tiene_objetivos
 */
class VswReporteFinal extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function primaryKey() {
        return 'id_persona_evaluado';
    }

    public function tableName() {
        return 'evaluacion.vsw_reporte_final';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_persona_evaluado, cedula, cod_dependencia_evaluado, id_evaluacion, id_persona, cod_dependencia_evaluador, fk_estatus_evaluacion', 'numerical', 'integerOnly' => true),
            array('nacionalidad, activo, tipo_cargo', 'length', 'max' => 1),
            array('descripcion_cargo', 'length', 'max' => 60),
            array('dependencia, dep_evaluador', 'length', 'max' => 90),
            array('apellidos, nombres, fk_tipo_clase, fecha_creacion_evaluacion, estatus, tiene_objetivos', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_persona_evaluado, nacionalidad, cedula, apellidos, nombres, descripcion_cargo, activo, cod_dependencia_evaluado, dependencia, tipo_cargo, fk_tipo_clase, id_evaluacion, fecha_creacion_evaluacion, id_persona, cod_dependencia_evaluador, dep_evaluador, fk_estatus_evaluacion, estatus, tiene_objetivos', 'safe', 'on' => 'search'),
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
            'id_persona_evaluado' => 'Id Persona Evaluado',
            'nacionalidad' => 'Nacionalidad',
            'cedula' => 'Cedula',
            'apellidos' => 'Apellidos',
            'nombres' => 'Nombres',
            'descripcion_cargo' => 'Descripcion Cargo',
            'activo' => 'Activo',
            'cod_dependencia_evaluado' => 'Cod Dependencia Evaluado',
            'dependencia' => 'Dependencia',
            'tipo_cargo' => 'Tipo Cargo',
            'fk_tipo_clase' => 'Fk Tipo Clase',
            'id_evaluacion' => 'Id Evaluacion',
            'fecha_creacion_evaluacion' => 'Fecha Creacion Evaluacion',
            'id_persona' => 'Id Persona',
            'cod_dependencia_evaluador' => 'Cod Dependencia Evaluador',
            'dep_evaluador' => 'Dep Evaluador',
            'fk_estatus_evaluacion' => 'Fk Estatus Evaluacion',
            'estatus' => 'Estatus',
            'tiene_objetivos' => 'Tiene Objetivos',
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

        $criteria->compare('id_persona_evaluado', $this->id_persona_evaluado);
        $criteria->compare('nacionalidad', $this->nacionalidad, true);
        $criteria->compare('cedula', $this->cedula);
        $criteria->compare('apellidos', $this->apellidos, true);
        $criteria->compare('nombres', $this->nombres, true);
        $criteria->compare('descripcion_cargo', $this->descripcion_cargo, true);
        $criteria->compare('activo', $this->activo, true);
        $criteria->compare('cod_dependencia_evaluado', $this->cod_dependencia_evaluado);
        $criteria->compare('dependencia', $this->dependencia, true);
        $criteria->compare('tipo_cargo', $this->tipo_cargo, true);
        $criteria->compare('fk_tipo_clase', $this->fk_tipo_clase, true);
        $criteria->compare('id_evaluacion', $this->id_evaluacion);
        $criteria->compare('fecha_creacion_evaluacion', $this->fecha_creacion_evaluacion, true);
        $criteria->compare('id_persona', $this->id_persona);
        $criteria->compare('cod_dependencia_evaluador', $this->cod_dependencia_evaluador);
        $criteria->compare('dep_evaluador', $this->dep_evaluador, true);
        $criteria->compare('fk_estatus_evaluacion', $this->fk_estatus_evaluacion);
        $criteria->compare('estatus', $this->estatus, true);
        $criteria->compare('tiene_objetivos', $this->tiene_objetivos, true);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return VswReporteFinal the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
