<?php

/**
 * This is the model class for table "evaluacion.evaluacion".
 *
 * The followings are the available columns in table 'evaluacion.evaluacion':
 * @property integer $id_evaluacion
 * @property integer $fk_evaluador
 * @property integer $fk_evaluado
 * @property integer $total_b
 * @property string $total_c
 * @property string $total_final
 * @property boolean $esta_conforme
 * @property integer $fk_estatus
 * @property string $created_date
 * @property string $modified_date
 * @property integer $created_by
 * @property integer $modified_by
 * @property boolean $es_activo
 * @property string $obj_funcional
 * @property integer $fk_rango_act
 *
 * The followings are the available model relations:
 * @property PreguntasColectivas[] $preguntasColectivases
 * @property Revision[] $revisions
 * @property Maestro $fkEstatus
 * @property Evaluador $fkEvaluador
 * @property Evaluados $fkEvaluado
 * @property Maestro $fkRangoAct
 * @property PreguntasObrero[] $preguntasObreros
 * @property PreguntasIndividuales[] $preguntasIndividuales
 * @property Comentarios[] $comentarioses
 * @property EstatusEvaluacion[] $estatusEvaluacions
 */
class Evaluacion extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.evaluacion';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('fk_estatus, created_date, modified_date, created_by, es_activo', 'required'),
			array('fk_evaluador, fk_evaluado, total_b, fk_estatus, created_by, modified_by, fk_rango_act', 'numerical', 'integerOnly'=>true),
			array('obj_funcional', 'length', 'max'=>200),
			array('total_c, total_final, esta_conforme', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_evaluacion, fk_evaluador, fk_evaluado, total_b, total_c, total_final, esta_conforme, fk_estatus, created_date, modified_date, created_by, modified_by, es_activo, obj_funcional, fk_rango_act', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'preguntasColectivases' => array(self::HAS_MANY, 'PreguntasColectivas', 'fk_evaluacion'),
			'revisions' => array(self::HAS_MANY, 'Revision', 'fk_evaluacion'),
			'fkEstatus' => array(self::BELONGS_TO, 'Maestro', 'fk_estatus'),
			'fkEvaluador' => array(self::BELONGS_TO, 'Evaluador', 'fk_evaluador'),
			'fkEvaluado' => array(self::BELONGS_TO, 'Evaluados', 'fk_evaluado'),
			'fkRangoAct' => array(self::BELONGS_TO, 'Maestro', 'fk_rango_act'),
			'preguntasObreros' => array(self::HAS_MANY, 'PreguntasObrero', 'fk_evaluacion'),
			'preguntasIndividuales' => array(self::HAS_MANY, 'PreguntasIndividuales', 'fk_evaluacion'),
			'comentarioses' => array(self::HAS_MANY, 'Comentarios', 'fk_evaluacion'),
			'estatusEvaluacions' => array(self::HAS_MANY, 'EstatusEvaluacion', 'fk_evaluacion'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_evaluacion' => 'Id Evaluacion',
			'fk_evaluador' => 'Fk Evaluador',
			'fk_evaluado' => 'Fk Evaluado',
			'total_b' => 'Total B',
			'total_c' => 'Total C',
			'total_final' => 'Total Final',
			'esta_conforme' => 'Esta Conforme',
			'fk_estatus' => 'Fk Estatus',
			'created_date' => 'Created Date',
			'modified_date' => 'Modified Date',
			'created_by' => 'Created By',
			'modified_by' => 'Modified By',
			'es_activo' => 'Es Activo',
			'obj_funcional' => 'Obj Funcional',
			'fk_rango_act' => 'Fk Rango Act',
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
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id_evaluacion',$this->id_evaluacion);
		$criteria->compare('fk_evaluador',$this->fk_evaluador);
		$criteria->compare('fk_evaluado',$this->fk_evaluado);
		$criteria->compare('total_b',$this->total_b);
		$criteria->compare('total_c',$this->total_c,true);
		$criteria->compare('total_final',$this->total_final,true);
		$criteria->compare('esta_conforme',$this->esta_conforme);
		$criteria->compare('fk_estatus',$this->fk_estatus);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('es_activo',$this->es_activo);
		$criteria->compare('obj_funcional',$this->obj_funcional,true);
		$criteria->compare('fk_rango_act',$this->fk_rango_act);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Evaluacion the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
