<?php

/**
 * This is the model class for table "evaluacion.vsw_pdf_reporte".
 *
 * The followings are the available columns in table 'evaluacion.vsw_pdf_reporte':
 * @property integer $id_persona_evaluado
 * @property string $apellidos_evaluado
 * @property string $nombres_evaluado
 * @property integer $nac_evaluado
 * @property string $nacionalidad_evaluado
 * @property integer $cedula_evaluado
 * @property integer $id_sexo_evaluado
 * @property string $sexo_evaluado
 * @property integer $cod_nomina_evaluado
 * @property integer $fk_cargo_evaluado
 * @property string $cargo_evaluado
 * @property integer $entidad_evaluado
 * @property string $oficina_evaluado
 * @property integer $telefono_evaluado
 * @property integer $id_persona
 * @property integer $id_evaluacion
 * @property integer $fk_periodo
 * @property string $periodo_evaluacion
 * @property string $apellidos
 * @property string $nombres
 * @property integer $fk_nacionalidad
 * @property string $nacionalidad
 * @property integer $cedula
 * @property integer $fk_sexo
 * @property string $sexo
 * @property integer $codigo_nomina
 * @property integer $fk_cargo
 * @property string $cargo
 * @property integer $fk_tipo_entidad
 * @property string $dependencia
 * @property integer $telef_oficina
 * @property integer $fk_estatus_evaluacion
 * @property string $estatus
 * @property string $cant_objetivos
 * @property string $peso_total
 */
class VswPdfReporte extends CActiveRecord {

    public function primaryKey() {
        return 'id_persona_evaluado';
    }

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'evaluacion.vsw_pdf_reporte';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_persona_evaluado, nac_evaluado, cedula_evaluado, id_sexo_evaluado, cod_nomina_evaluado, fk_cargo_evaluado, entidad_evaluado, telefono_evaluado, id_persona, id_evaluacion, fk_periodo, fk_nacionalidad, cedula, fk_sexo, codigo_nomina, fk_cargo, fk_tipo_entidad, telef_oficina, fk_estatus_evaluacion', 'numerical', 'integerOnly' => true),
            array('apellidos_evaluado, nombres_evaluado, apellidos, nombres', 'length', 'max' => 50),
            array('cargo_evaluado, cargo', 'length', 'max' => 100),
            array('nacionalidad_evaluado, sexo_evaluado, oficina_evaluado, periodo_evaluacion, nacionalidad, sexo, dependencia, estatus, cant_objetivos, peso_total', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_persona_evaluado, apellidos_evaluado, nombres_evaluado, nac_evaluado, nacionalidad_evaluado, cedula_evaluado, id_sexo_evaluado, sexo_evaluado, cod_nomina_evaluado, fk_cargo_evaluado, cargo_evaluado, entidad_evaluado, oficina_evaluado, telefono_evaluado, id_persona, id_evaluacion, fk_periodo, periodo_evaluacion, apellidos, nombres, fk_nacionalidad, nacionalidad, cedula, fk_sexo, sexo, codigo_nomina, fk_cargo, cargo, fk_tipo_entidad, dependencia, telef_oficina, fk_estatus_evaluacion, estatus, cant_objetivos, peso_total', 'safe', 'on' => 'search'),
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
            'nac_evaluado' => 'Nac Evaluado',
            'nacionalidad_evaluado' => 'Nacionalidad Evaluado',
            'cedula_evaluado' => 'Cedula Evaluado',
            'id_sexo_evaluado' => 'Id Sexo Evaluado',
            'sexo_evaluado' => 'Sexo Evaluado',
            'cod_nomina_evaluado' => 'Cod Nomina Evaluado',
            'fk_cargo_evaluado' => 'Fk Cargo Evaluado',
            'cargo_evaluado' => 'Cargo Evaluado',
            'entidad_evaluado' => 'Entidad Evaluado',
            'oficina_evaluado' => 'Oficina Evaluado',
            'telefono_evaluado' => 'Telefono Evaluado',
            'id_persona' => 'Id Persona',
            'id_evaluacion' => 'Id Evaluacion',
            'fk_periodo' => 'Fk Periodo',
            'periodo_evaluacion' => 'Periodo Evaluacion',
            'apellidos' => 'Apellidos',
            'nombres' => 'Nombres',
            'fk_nacionalidad' => 'Fk Nacionalidad',
            'nacionalidad' => 'Nacionalidad',
            'cedula' => 'Cedula',
            'fk_sexo' => 'Fk Sexo',
            'sexo' => 'Sexo',
            'codigo_nomina' => 'Codigo Nomina',
            'fk_cargo' => 'Fk Cargo',
            'cargo' => 'Cargo',
            'fk_tipo_entidad' => 'Fk Tipo Entidad',
            'dependencia' => 'Dependencia',
            'telef_oficina' => 'Telef Oficina',
            'fk_estatus_evaluacion' => 'Fk Estatus Evaluacion',
            'estatus' => 'Estatus',
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
        $criteria->compare('nac_evaluado', $this->nac_evaluado);
        $criteria->compare('nacionalidad_evaluado', $this->nacionalidad_evaluado, true);
        $criteria->compare('cedula_evaluado', $this->cedula_evaluado);
        $criteria->compare('id_sexo_evaluado', $this->id_sexo_evaluado);
        $criteria->compare('sexo_evaluado', $this->sexo_evaluado, true);
        $criteria->compare('cod_nomina_evaluado', $this->cod_nomina_evaluado);
        $criteria->compare('fk_cargo_evaluado', $this->fk_cargo_evaluado);
        $criteria->compare('cargo_evaluado', $this->cargo_evaluado, true);
        $criteria->compare('entidad_evaluado', $this->entidad_evaluado);
        $criteria->compare('oficina_evaluado', $this->oficina_evaluado, true);
        $criteria->compare('telefono_evaluado', $this->telefono_evaluado);
        $criteria->compare('id_persona', $this->id_persona);
        $criteria->compare('id_evaluacion', $this->id_evaluacion);
        $criteria->compare('fk_periodo', $this->fk_periodo);
        $criteria->compare('periodo_evaluacion', $this->periodo_evaluacion, true);
        $criteria->compare('apellidos', $this->apellidos, true);
        $criteria->compare('nombres', $this->nombres, true);
        $criteria->compare('fk_nacionalidad', $this->fk_nacionalidad);
        $criteria->compare('nacionalidad', $this->nacionalidad, true);
        $criteria->compare('cedula', $this->cedula);
        $criteria->compare('fk_sexo', $this->fk_sexo);
        $criteria->compare('sexo', $this->sexo, true);
        $criteria->compare('codigo_nomina', $this->codigo_nomina);
        $criteria->compare('fk_cargo', $this->fk_cargo);
        $criteria->compare('cargo', $this->cargo, true);
        $criteria->compare('fk_tipo_entidad', $this->fk_tipo_entidad);
        $criteria->compare('dependencia', $this->dependencia, true);
        $criteria->compare('telef_oficina', $this->telef_oficina);
        $criteria->compare('fk_estatus_evaluacion', $this->fk_estatus_evaluacion);
        $criteria->compare('estatus', $this->estatus, true);
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
     * @return VswPdfReporte the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
