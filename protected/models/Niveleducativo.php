<?php

/**
 * This is the model class for table "niveleducativo".
 *
 * The followings are the available columns in table 'niveleducativo':
 * @property integer $id_nivel_educativo
 * @property string $cod_nivel_educativo
 * @property string $descripcion
 * @property integer $orden
 *
 * The followings are the available model relations:
 * @property Educacion[] $educacions
 * @property Titulo[] $titulos
 */
class Niveleducativo extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'niveleducativo';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_nivel_educativo, cod_nivel_educativo, descripcion', 'required'),
            array('id_nivel_educativo, orden', 'numerical', 'integerOnly' => true),
            array('cod_nivel_educativo', 'length', 'max' => 1),
            array('descripcion', 'length', 'max' => 60),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_nivel_educativo, cod_nivel_educativo, descripcion, orden', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'educacions' => array(self::HAS_MANY, 'Educacion', 'id_nivel_educativo'),
            'titulos' => array(self::HAS_MANY, 'Titulo', 'id_nivel_educativo'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_nivel_educativo' => 'Nivel Educativo',
            'cod_nivel_educativo' => 'Cod Nivel Educativo',
            'descripcion' => 'Descripcion',
            'orden' => 'Orden',
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

        $criteria->compare('id_nivel_educativo', $this->id_nivel_educativo);
        $criteria->compare('cod_nivel_educativo', $this->cod_nivel_educativo, true);
        $criteria->compare('descripcion', $this->descripcion, true);
        $criteria->compare('orden', $this->orden);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

////        funcion que permite hacer la busqueda por id sobre el nivel educativo
    public function FindBuscarByPadreSelect($IdNivelEducativo) {
        $criteria = new CDbCriteria;
        $data = CHtml::listData(self::model()->findAll($criteria), 'id_nivel_educativo', 'descripcion');
        return $data;
    }

    /**
     * @return CDbConnection the database connection used for this class
     */
    public function getDbConnection() {
        return Yii::app()->db2;
    }

    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return Niveleducativo the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
