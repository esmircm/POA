<?php

/**
 * This is the model class for table "puebloindigena".
 *
 * The followings are the available columns in table 'puebloindigena':
 * @property integer $id_pueblo_indigena
 * @property string $cod_pueblo_indigena
 * @property string $descripcion
 */
class Puebloindigena extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'puebloindigena';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('descripcion', 'required'),
            array('id_pueblo_indigena', 'numerical', 'integerOnly' => true),
            array('cod_pueblo_indigena', 'length', 'max' => 6),
            array('descripcion', 'length', 'max' => 100),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_pueblo_indigena, cod_pueblo_indigena, descripcion', 'safe', 'on' => 'search'),
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
            'id_pueblo_indigena' => 'Pueblo Indigena',
            'cod_pueblo_indigena' => 'Pueblo Indigena',
            'descripcion' => 'Descripcion',
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

        $criteria->compare('id_pueblo_indigena', $this->id_pueblo_indigena);
        $criteria->compare('cod_pueblo_indigena', $this->cod_pueblo_indigena, true);
        $criteria->compare('descripcion', $this->descripcion, true);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    public function FindBuscarPuebloindigenaByPadreSelect($IdPuebloindigena) {
        $criteria = new CDbCriteria;
        $data = CHtml::listData(self::model()->findAll($criteria), 'id_pueblo_indigena', 'descripcion');
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
     * @return Puebloindigena the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
