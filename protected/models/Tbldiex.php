<?php

/**
 * This is the model class for table "tbldiex".
 *
 * The followings are the available columns in table 'tbldiex':
 * @property string $strnacionalidad
 * @property integer $intcedula
 * @property string $strnombre_primer
 * @property string $strnombre_segundo
 * @property string $strapellido_primer
 * @property string $strapellido_segundo
 * @property string $dtmnacimiento
 * @property string $strgenero
 * @property integer $clvestado_civil
 * @property string $clvobjecion
 * @property string $dtmregistro
 * @property string $dtmmodificado
 * @property boolean $blnborrado
 * @property integer $clvusuario
 */
class Tbldiex extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'tbldiex';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('intcedula, clvestado_civil, clvusuario', 'numerical', 'integerOnly'=>true),
			array('strnacionalidad, strgenero', 'length', 'max'=>1),
			array('clvobjecion', 'length', 'max'=>2),
			array('strnombre_primer, strnombre_segundo, strapellido_primer, strapellido_segundo, dtmnacimiento, dtmregistro, dtmmodificado, blnborrado', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('strnacionalidad, intcedula, strnombre_primer, strnombre_segundo, strapellido_primer, strapellido_segundo, dtmnacimiento, strgenero, clvestado_civil, clvobjecion, dtmregistro, dtmmodificado, blnborrado, clvusuario', 'safe', 'on'=>'search'),
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
			'strnacionalidad' => 'Strnacionalidad',
			'intcedula' => 'Intcedula',
			'strnombre_primer' => 'Strnombre Primer',
			'strnombre_segundo' => 'Strnombre Segundo',
			'strapellido_primer' => 'Strapellido Primer',
			'strapellido_segundo' => 'Strapellido Segundo',
			'dtmnacimiento' => 'Dtmnacimiento',
			'strgenero' => 'Strgenero',
			'clvestado_civil' => 'Clvestado Civil',
			'clvobjecion' => 'Clvobjecion',
			'dtmregistro' => 'Dtmregistro',
			'dtmmodificado' => 'Dtmmodificado',
			'blnborrado' => 'Blnborrado',
			'clvusuario' => 'Clvusuario',
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

		$criteria->compare('strnacionalidad',$this->strnacionalidad,true);
		$criteria->compare('intcedula',$this->intcedula);
		$criteria->compare('strnombre_primer',$this->strnombre_primer,true);
		$criteria->compare('strnombre_segundo',$this->strnombre_segundo,true);
		$criteria->compare('strapellido_primer',$this->strapellido_primer,true);
		$criteria->compare('strapellido_segundo',$this->strapellido_segundo,true);
		$criteria->compare('dtmnacimiento',$this->dtmnacimiento,true);
		$criteria->compare('strgenero',$this->strgenero,true);
		$criteria->compare('clvestado_civil',$this->clvestado_civil);
		$criteria->compare('clvobjecion',$this->clvobjecion,true);
		$criteria->compare('dtmregistro',$this->dtmregistro,true);
		$criteria->compare('dtmmodificado',$this->dtmmodificado,true);
		$criteria->compare('blnborrado',$this->blnborrado);
		$criteria->compare('clvusuario',$this->clvusuario);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * @return CDbConnection the database connection used for this class
	 */
	public function getDbConnection()
	{
		return Yii::app()->db4;
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Tbldiex the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
