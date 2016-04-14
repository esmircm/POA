<?php

/**
 * This is the model class for table "poa.actividades".
 *
 * The followings are the available columns in table 'poa.actividades':
 * @property integer $id_actividades
 * @property string $actividad
 * @property integer $fk_unidad_medida
 * @property integer $cantidad
 * @property integer $fk_accion
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 * @property integer $fk_status
 * @property boolean $es_activo
 *
 * The followings are the available model relations:
 * @property Maestro $fkStatus
 * @property Acciones $fkAccion
 * @property Maestro $fkUnidadMedida
 * @property Rendimiento[] $rendimientos
 */
class Actividades extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'poa.actividades';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('fk_unidad_medida, fk_accion, created_by, created_date, modified_date, fk_status', 'required'),
			array('fk_unidad_medida, cantidad, fk_accion, created_by, modified_by, fk_status', 'numerical', 'integerOnly'=>true),
			array('actividad', 'length', 'max'=>200),
			array('es_activo', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_actividades, actividad, fk_unidad_medida, cantidad, fk_accion, created_by, created_date, modified_by, modified_date, fk_status, es_activo', 'safe', 'on'=>'search'),
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
			'fkStatus' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_status'),
			'fkAccion' => array(self::BELONGS_TO, 'Acciones', 'fk_accion'),
			'fkUnidadMedida' => array(self::BELONGS_TO, 'MaestroPoa', 'fk_unidad_medida'),
			'rendimientos' => array(self::HAS_MANY, 'Rendimiento', 'fk_actividad'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_actividades' => 'Id Actividades',
			'actividad' => 'Actividad',
			'fk_unidad_medida' => 'Unidad de Medida',
			'cantidad' => 'Cantidad',
			'fk_accion' => 'Acción',
			'created_by' => 'Created By',
			'created_date' => 'Created Date',
			'modified_by' => 'Modified By',
			'modified_date' => 'Modified Date',
			'fk_status' => 'Fk Status',
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
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id_actividades',$this->id_actividades);
		$criteria->compare('actividad',$this->actividad,true);
		$criteria->compare('fk_unidad_medida',$this->fk_unidad_medida);
		$criteria->compare('cantidad',$this->cantidad);
		$criteria->compare('fk_accion',$this->fk_accion);
		$criteria->compare('created_by',$this->created_by);
		$criteria->compare('created_date',$this->created_date,true);
		$criteria->compare('modified_by',$this->modified_by);
		$criteria->compare('modified_date',$this->modified_date,true);
		$criteria->compare('fk_status',$this->fk_status);
		$criteria->compare('es_activo',$this->es_activo);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        public function suma_rendimiento($id_actividad, $condicion) 
        {
            $consulta = Yii::app()->db->createCommand()
                ->select('CASE WHEN SUM(cantidad_cumplida) is null THEN 0 ELSE SUM(cantidad_cumplida) END')
                ->from('poa.rendimiento')
                ->where('id_entidad = ' . $id_actividad . ' AND fk_tipo_entidad = 74 ' . $condicion)
                ->queryRow();
            
                $resultado = $consulta['sum'];
                return $resultado;
        }
        
        
        public function suma_programado($id_actividad, $condicion) 
        {
            $consulta = Yii::app()->db->createCommand()
                ->select('CASE WHEN SUM(cantidad_programada) is null THEN 0 ELSE SUM(cantidad_programada) END')
                ->from('poa.rendimiento')
                ->where('id_entidad = ' . $id_actividad . ' AND fk_tipo_entidad = 74 ' . $condicion)
                ->queryRow();
            
                $resultado = $consulta['sum'];
                return $resultado;
        }

        /**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Actividades the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
