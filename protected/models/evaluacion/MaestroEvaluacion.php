<?php

/**
 * This is the model class for table "evaluacion.maestro".
 *
 * The followings are the available columns in table 'evaluacion.maestro':
 * @property integer $id_maestro
 * @property string $descripcion
 * @property integer $padre
 * @property integer $hijo
 * @property string $created_date
 * @property string $modified_date
 * @property integer $created_by
 * @property integer $modified_by
 * @property boolean $es_activo
 *
 * The followings are the available model relations:
 * @property Evaluador[] $evaluadors
 * @property Evaluador[] $evaluadors1
 * @property Comentarios[] $comentarioses
 * @property Comentarios[] $comentarioses1
 * @property PreguntasObrero[] $preguntasObreros
 * @property PreguntasIndividuales[] $preguntasIndividuales
 * @property PreguntasIndividuales[] $preguntasIndividuales1
 * @property Evaluacion[] $evaluacions
 * @property Preguntas[] $preguntases
 * @property Preguntas[] $preguntases1
 * @property Evaluados[] $evaluadoses
 * @property Supervisor[] $supervisors
 * @property Persona[] $personas
 * @property Persona[] $personas1
 * @property PreguntasColectivas[] $preguntasColectivases
 * @property PreguntasColectivas[] $preguntasColectivases1
 * @property PreguntasColectivas[] $preguntasColectivases2
 */
class MaestroEvaluacion extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'evaluacion.maestro';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('descripcion, created_date, modified_date, created_by', 'required'),
            array('padre, hijo, created_by, modified_by', 'numerical', 'integerOnly' => true),
            array('es_activo', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_maestro, descripcion, padre, hijo, created_date, modified_date, created_by, modified_by, es_activo', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'evaluadors' => array(self::HAS_MANY, 'Evaluador', 'fk_estatus'),
            'evaluadors1' => array(self::HAS_MANY, 'Evaluador', 'fk_persona'),
            'comentarioses' => array(self::HAS_MANY, 'Comentarios', 'fk_estatus'),
            'comentarioses1' => array(self::HAS_MANY, 'Comentarios', 'fk_tipo_entidad'),
            'preguntasObreros' => array(self::HAS_MANY, 'PreguntasObrero', 'fk_estatus'),
            'preguntasIndividuales' => array(self::HAS_MANY, 'PreguntasIndividuales', 'fk_estatus'),
            'preguntasIndividuales1' => array(self::HAS_MANY, 'PreguntasIndividuales', 'fk_rango'),
            'evaluacions' => array(self::HAS_MANY, 'Evaluacion', 'fk_estatus'),
            'preguntases' => array(self::HAS_MANY, 'Preguntas', 'fk_estatus'),
            'preguntases1' => array(self::HAS_MANY, 'Preguntas', 'fk_tipo_clase'),
            'evaluadoses' => array(self::HAS_MANY, 'Evaluados', 'fk_estatus'),
            'supervisors' => array(self::HAS_MANY, 'Supervisor', 'fk_estatus'),
            'personas' => array(self::HAS_MANY, 'Persona', 'fk_nacionalidad'),
            'personas1' => array(self::HAS_MANY, 'Persona', 'fk_estatus'),
            'preguntasColectivases' => array(self::HAS_MANY, 'PreguntasColectivas', 'fk_estatus'),
            'preguntasColectivases1' => array(self::HAS_MANY, 'PreguntasColectivas', 'fk_rango'),
            'preguntasColectivases2' => array(self::HAS_MANY, 'PreguntasColectivas', 'fk_tipo_clase'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_maestro' => 'Id Maestro',
            'descripcion' => 'Descripcion',
            'padre' => 'Padre',
            'hijo' => 'Hijo',
            'created_date' => 'Created Date',
            'modified_date' => 'Modified Date',
            'created_by' => 'Created By',
            'modified_by' => 'Modified By',
            'es_activo' => 'Es Activo',
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

        $criteria->compare('id_maestro', $this->id_maestro);
        $criteria->compare('descripcion', $this->descripcion, true);
        $criteria->compare('padre', $this->padre);
        $criteria->compare('hijo', $this->hijo);
        $criteria->compare('created_date', $this->created_date, true);
        $criteria->compare('modified_date', $this->modified_date, true);
        $criteria->compare('created_by', $this->created_by);
        $criteria->compare('modified_by', $this->modified_by);
        $criteria->compare('es_activo', $this->es_activo);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return Maestro the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
