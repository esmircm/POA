<?php

/**
 * This is the model class for table "evaluacion.vsw_listar_personas".
 *
 * The followings are the available columns in table 'evaluacion.vsw_listar_personas':
 * @property integer $id_persona_evaluado
 * @property string $apellidos_evaluado
 * @property string $nombres_evaluado
 * @property string $nacionalidad_evaluado
 * @property integer $cedula_evaluado
 * @property string $sexo_evaluado
 * @property integer $cod_nomina_evaluado
 * @property integer $fk_cargo_evaluado
 * @property string $cargo_evaluado
 * @property string $fecha_creacion_evaluacion
 * @property string $fk_tipo_clase
 * @property integer $cod_oficina_evaluado
 * @property string $oficina_evaluado
 * @property string $telefono_evaluado
 * @property integer $id_persona
 * @property integer $id_evaluacion
 * @property integer $fk_periodo
 * @property string $periodo_evaluacion
 * @property string $apellidos
 * @property string $nombres
 * @property string $nacionalidad
 * @property integer $cedula
 * @property string $sexo
 * @property integer $codigo_nomina
 * @property integer $fk_cargo
 * @property string $descripcion_cargo
 * @property integer $cod_dependencia
 * @property string $dependencia
 * @property string $telef_oficina
 * @property string $obj_funcional
 * @property integer $fk_estatus_evaluacion
 * @property string $estatus
 * @property integer $id_comentario
 * @property string $comentario
 * @property string $tiene_objetivos
 * @property string $cant_objetivos
 * @property string $peso_total
 */
class VswListarPersonas extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'evaluacion.vsw_listar_personas';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_persona_evaluado, cedula_evaluado, cod_nomina_evaluado, fk_cargo_evaluado, cod_oficina_evaluado, id_persona, id_evaluacion, fk_periodo, cedula, codigo_nomina, fk_cargo, cod_dependencia, fk_estatus_evaluacion, id_comentario', 'numerical', 'integerOnly' => true),
            array('nacionalidad_evaluado, sexo_evaluado, nacionalidad, sexo', 'length', 'max' => 1),
            array('cargo_evaluado, descripcion_cargo', 'length', 'max' => 60),
            array('oficina_evaluado, dependencia', 'length', 'max' => 90),
            array('telefono_evaluado, telef_oficina', 'length', 'max' => 15),
            array('obj_funcional', 'length', 'max' => 200),
            array('comentario', 'length', 'max' => 500),
            array('apellidos_evaluado, nombres_evaluado, fecha_creacion_evaluacion, fk_tipo_clase, periodo_evaluacion, apellidos, nombres, estatus, tiene_objetivos, cant_objetivos, peso_total', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_persona_evaluado, apellidos_evaluado, nombres_evaluado, nacionalidad_evaluado, cedula_evaluado, sexo_evaluado, cod_nomina_evaluado, fk_cargo_evaluado, cargo_evaluado, fecha_creacion_evaluacion, fk_tipo_clase, cod_oficina_evaluado, oficina_evaluado, telefono_evaluado, id_persona, id_evaluacion, fk_periodo, periodo_evaluacion, apellidos, nombres, nacionalidad, cedula, sexo, codigo_nomina, fk_cargo, descripcion_cargo, cod_dependencia, dependencia, telef_oficina, obj_funcional, fk_estatus_evaluacion, estatus, id_comentario, comentario, tiene_objetivos, cant_objetivos, peso_total', 'safe', 'on' => 'search'),
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
            'apellidos_evaluado' => 'Apellidos Evaluado',
            'nombres_evaluado' => 'Nombres Evaluado',
            'nacionalidad_evaluado' => 'Nacionalidad Evaluado',
            'cedula_evaluado' => 'Cedula Evaluado',
            'sexo_evaluado' => 'Sexo Evaluado',
            'cod_nomina_evaluado' => 'Cod Nomina Evaluado',
            'fk_cargo_evaluado' => 'Fk Cargo Evaluado',
            'cargo_evaluado' => 'Cargo Evaluado',
            'fecha_creacion_evaluacion' => 'Fecha Creacion Evaluacion',
            'fk_tipo_clase' => 'Fk Tipo Clase',
            'cod_oficina_evaluado' => 'Cod Oficina Evaluado',
            'oficina_evaluado' => 'Oficina Evaluado',
            'telefono_evaluado' => 'Telefono Evaluado',
            'id_persona' => 'Id Persona',
            'id_evaluacion' => 'Id Evaluacion',
            'fk_periodo' => 'Fk Periodo',
            'periodo_evaluacion' => 'Periodo Evaluacion',
            'apellidos' => 'Apellidos',
            'nombres' => 'Nombres',
            'nacionalidad' => 'Nacionalidad',
            'cedula' => 'Cedula',
            'sexo' => 'Sexo',
            'codigo_nomina' => 'Codigo Nomina',
            'fk_cargo' => 'Fk Cargo',
            'descripcion_cargo' => 'Descripcion Cargo',
            'cod_dependencia' => 'Cod Dependencia',
            'dependencia' => 'Dependencia',
            'telef_oficina' => 'Telef Oficina',
            'obj_funcional' => 'Obj Funcional',
            'fk_estatus_evaluacion' => 'Fk Estatus Evaluacion',
            'estatus' => 'Estatus',
            'id_comentario' => 'Id Comentario',
            'comentario' => 'Comentario',
            'tiene_objetivos' => 'Tiene Objetivos',
            'cant_objetivos' => 'Cant Objetivos',
            'peso_total' => 'Peso Total',
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
        $criteria->compare('apellidos_evaluado', $this->apellidos_evaluado, true);
        $criteria->compare('nombres_evaluado', $this->nombres_evaluado, true);
        $criteria->compare('nacionalidad_evaluado', $this->nacionalidad_evaluado, true);
        $criteria->compare('cedula_evaluado', $this->cedula_evaluado);
        $criteria->compare('sexo_evaluado', $this->sexo_evaluado, true);
        $criteria->compare('cod_nomina_evaluado', $this->cod_nomina_evaluado);
        $criteria->compare('fk_cargo_evaluado', $this->fk_cargo_evaluado);
        $criteria->compare('cargo_evaluado', $this->cargo_evaluado, true);
        $criteria->compare('fecha_creacion_evaluacion', $this->fecha_creacion_evaluacion, true);
        $criteria->compare('fk_tipo_clase', $this->fk_tipo_clase, true);
        $criteria->compare('cod_oficina_evaluado', $this->cod_oficina_evaluado);
        $criteria->compare('oficina_evaluado', $this->oficina_evaluado, true);
        $criteria->compare('telefono_evaluado', $this->telefono_evaluado, true);
        $criteria->compare('id_persona', $this->id_persona);
        $criteria->compare('id_evaluacion', $this->id_evaluacion);
        $criteria->compare('fk_periodo', $this->fk_periodo);
        $criteria->compare('periodo_evaluacion', $this->periodo_evaluacion, true);
        $criteria->compare('apellidos', $this->apellidos, true);
        $criteria->compare('nombres', $this->nombres, true);
        $criteria->compare('nacionalidad', $this->nacionalidad, true);
        $criteria->compare('cedula', $this->cedula);
        $criteria->compare('sexo', $this->sexo, true);
        $criteria->compare('codigo_nomina', $this->codigo_nomina);
        $criteria->compare('fk_cargo', $this->fk_cargo);
        $criteria->compare('descripcion_cargo', $this->descripcion_cargo, true);
        $criteria->compare('cod_dependencia', $this->cod_dependencia);
        $criteria->compare('dependencia', $this->dependencia, true);
        $criteria->compare('telef_oficina', $this->telef_oficina, true);
        $criteria->compare('obj_funcional', $this->obj_funcional, true);
        $criteria->compare('fk_estatus_evaluacion', $this->fk_estatus_evaluacion);
        $criteria->compare('estatus', $this->estatus, true);
        $criteria->compare('id_comentario', $this->id_comentario);
        $criteria->compare('comentario', $this->comentario, true);
        $criteria->compare('tiene_objetivos', $this->tiene_objetivos, true);
        $criteria->compare('cant_objetivos', $this->cant_objetivos, true);
        $criteria->compare('peso_total', $this->peso_total, true);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    public function searchlistar($estatus_evaluacion, $estatus_evaluacion1, $fecha_ini, $fecha_fin) {
// @todo Please modify the following code to remove attributes that should not be searched.
        
        $criteria = new CDbCriteria;
        $criteria->compare('id_persona_evaluado', $this->id_persona_evaluado);
        $criteria->compare('apellidos_evaluado', $this->apellidos_evaluado, true);
        $criteria->compare('nombres_evaluado', $this->nombres_evaluado, true);
        $criteria->compare('nacionalidad_evaluado', $this->nacionalidad_evaluado, true);
        $criteria->compare('cedula_evaluado', $this->cedula_evaluado);
        $criteria->compare('sexo_evaluado', $this->sexo_evaluado, true);
        $criteria->compare('cod_nomina_evaluado', $this->cod_nomina_evaluado);
        $criteria->compare('fk_cargo_evaluado', $this->fk_cargo_evaluado);
        $criteria->compare('cargo_evaluado', $this->cargo_evaluado, true);
        $criteria->addBetweenCondition('fecha_creacion_evaluacion', $fecha_ini, $fecha_fin);
        $criteria->compare('fk_tipo_clase', $this->fk_tipo_clase, true);
        $criteria->compare('cod_oficina_evaluado', $this->cod_oficina_evaluado);
        $criteria->compare('oficina_evaluado', $this->oficina_evaluado, true);
        $criteria->compare('telefono_evaluado', $this->telefono_evaluado, true);
        $criteria->compare('id_persona', $this->id_persona);
        $criteria->compare('id_evaluacion', $this->id_evaluacion);
        $criteria->compare('fk_periodo', $this->fk_periodo);
        $criteria->compare('periodo_evaluacion', $this->periodo_evaluacion, true);
        $criteria->compare('apellidos', $this->apellidos, true);
        $criteria->compare('nombres', $this->nombres, true);
        $criteria->compare('nacionalidad', $this->nacionalidad, true);
        $criteria->compare('cedula', $this->cedula);
        $criteria->compare('sexo', $this->sexo, true);
        $criteria->compare('codigo_nomina', $this->codigo_nomina);
        $criteria->compare('fk_cargo', $this->fk_cargo);
        $criteria->compare('descripcion_cargo', $this->descripcion_cargo, true);
        $criteria->compare('cod_dependencia', $this->cod_dependencia);
        $criteria->compare('dependencia', $this->dependencia, true);
        $criteria->compare('telef_oficina', $this->telef_oficina, true);
        $criteria->compare('obj_funcional', $this->obj_funcional, true);
        $criteria->compare('fk_estatus_evaluacion', $estatus_evaluacion);
        $criteria->compare('fk_estatus_evaluacion', $estatus_evaluacion1, false, 'OR'); //Consulta GridView RRHH
        $criteria->compare('estatus', $this->estatus, true);
        $criteria->compare('id_comentario', $this->id_comentario);
        $criteria->compare('comentario', $this->comentario, true);
        $criteria->compare('tiene_objetivos', $this->tiene_objetivos, true);
        $criteria->compare('cant_objetivos', $this->cant_objetivos, true);
        $criteria->compare('peso_total', $this->peso_total, true);




        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    public function searchlistarAdmin($id_persona, $dependencia, $fecha_ini, $fecha_fin) {
// @todo Please modify the following code to remove attributes that should not be searched.


        $criteria = new CDbCriteria;

        $criteria->compare('id_persona_evaluado', $this->id_persona_evaluado);
        $criteria->compare('apellidos_evaluado', $this->apellidos_evaluado, true);
        $criteria->compare('nombres_evaluado', $this->nombres_evaluado, true);
        $criteria->compare('nacionalidad_evaluado', $this->nacionalidad_evaluado, true);
        $criteria->compare('cedula_evaluado', $this->cedula_evaluado);
        $criteria->compare('sexo_evaluado', $this->sexo_evaluado, true);
        $criteria->compare('cod_nomina_evaluado', $this->cod_nomina_evaluado);
        $criteria->compare('fk_cargo_evaluado', $this->fk_cargo_evaluado);
        $criteria->compare('cargo_evaluado', $this->cargo_evaluado, true);
//        $criteria->compare('fecha_creacion_evaluacion', $this->fecha_creacion_evaluacion, true);
        $criteria->addBetweenCondition('fecha_creacion_evaluacion', $fecha_ini, $fecha_fin);
        $criteria->compare('fk_tipo_clase', $this->fk_tipo_clase, true);
        $criteria->compare('cod_oficina_evaluado', $this->cod_oficina_evaluado);
        $criteria->compare('oficina_evaluado', $this->oficina_evaluado, true);
        $criteria->compare('telefono_evaluado', $this->telefono_evaluado, true);
        $criteria->compare('id_persona', $id_persona);
        $criteria->compare('id_evaluacion', $this->id_evaluacion);
        $criteria->compare('fk_periodo', $this->fk_periodo);
        $criteria->compare('periodo_evaluacion', $this->periodo_evaluacion, true);
        $criteria->compare('apellidos', $this->apellidos, true);
        $criteria->compare('nombres', $this->nombres, true);
        $criteria->compare('nacionalidad', $this->nacionalidad, true);
        $criteria->compare('cedula', $this->cedula);
        $criteria->compare('sexo', $this->sexo, true);
        $criteria->compare('codigo_nomina', $this->codigo_nomina);
        $criteria->compare('fk_cargo', $this->fk_cargo);
        $criteria->compare('descripcion_cargo', $this->descripcion_cargo, true);
        $criteria->compare('cod_dependencia', $dependencia);
        $criteria->compare('dependencia', $this->dependencia, true);
        $criteria->compare('telef_oficina', $this->telef_oficina, true);
        $criteria->compare('obj_funcional', $this->obj_funcional, true);
        $criteria->compare('fk_estatus_evaluacion', $this->fk_estatus_evaluacion);
        $criteria->compare('estatus', $this->estatus, true);
        $criteria->compare('id_comentario', $this->id_comentario);
        $criteria->compare('comentario', $this->comentario, true);
        $criteria->compare('tiene_objetivos', $this->tiene_objetivos, true);
        $criteria->compare('cant_objetivos', $this->cant_objetivos, true);
        $criteria->compare('peso_total', $this->peso_total, true);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return VswListarPersonas the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
