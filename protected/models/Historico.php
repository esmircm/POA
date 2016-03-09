<?php

/**
 * This is the model class for table "actualizar.historico".
 *
 * The followings are the available columns in table 'actualizar.historico':
 * @property integer $id_historico
 * @property integer $id_personal
 * @property integer $id_usuario
 * @property boolean $se_activa_1
 * @property boolean $se_activa_2
 * @property boolean $se_activa_3
 */
class Historico extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'actualizar.historico';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_personal, id_usuario', 'numerical', 'integerOnly' => true),
            array('se_activa_1, se_activa_2, se_activa_3', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_historico, id_personal, id_usuario, se_activa_1, se_activa_2, se_activa_3', 'safe', 'on' => 'search'),
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
            'id_historico' => 'Id Historico',
            'id_personal' => 'Id Personal',
            'id_usuario' => 'Id Usuario',
            'se_activa_1' => 'Se Activa 1',
            'se_activa_2' => 'Se Activa 2',
            'se_activa_3' => 'Se Activa 3',
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

        $criteria->compare('id_historico', $this->id_historico);
        $criteria->compare('id_personal', $this->id_personal);
        $criteria->compare('id_usuario', $this->id_usuario);
        $criteria->compare('se_activa_1', $this->se_activa_1);
        $criteria->compare('se_activa_2', $this->se_activa_2);
        $criteria->compare('se_activa_3', $this->se_activa_3);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return Historico the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
