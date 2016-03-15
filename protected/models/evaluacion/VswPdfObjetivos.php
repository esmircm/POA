<?php

/**
 * This is the model class for table "evaluacion.vsw_pdf_objetivos".
 *
 * The followings are the available columns in table 'evaluacion.vsw_pdf_objetivos':
 * @property integer $id_evaluacion
 * @property integer $id_preguntas_ind
 * @property string $objetivo
 * @property integer $peso
 * @property integer $fk_rango
 * @property string $rango
 * @property integer $subtotal_peso
 */
class VswPdfObjetivos extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'evaluacion.vsw_pdf_objetivos';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_evaluacion, id_preguntas_ind, peso, fk_rango, subtotal_peso', 'numerical', 'integerOnly'=>true),
			array('objetivo', 'length', 'max'=>300),
			array('rango', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_evaluacion, id_preguntas_ind, objetivo, peso, fk_rango, rango, subtotal_peso', 'safe', 'on'=>'search'),
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
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_evaluacion' => 'Id Evaluacion',
			'id_preguntas_ind' => 'Id Preguntas Ind',
			'objetivo' => 'Objetivo',
			'peso' => 'Peso',
			'fk_rango' => 'Fk Rango',
			'rango' => 'Rango',
			'subtotal_peso' => 'Subtotal Peso',
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
		$criteria->compare('id_preguntas_ind',$this->id_preguntas_ind);
		$criteria->compare('objetivo',$this->objetivo,true);
		$criteria->compare('peso',$this->peso);
		$criteria->compare('fk_rango',$this->fk_rango);
		$criteria->compare('rango',$this->rango,true);
		$criteria->compare('subtotal_peso',$this->subtotal_peso);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return VswPdfObjetivos the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
