<?php

/**
 * This is the model class for table "maestro".
 *
 * The followings are the available columns in table 'maestro':
 * @property integer $id_maestro
 * @property string $descripcion
 * @property integer $padre
 * @property integer $hijo
 * @property boolean $es_activo
 * @property integer $fk_estatus
 * @property integer $created_by
 * @property string $created_date
 * @property integer $modified_by
 * @property string $modified_date
 * @property string $descripcion2
 */
class Maestro extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'maestro';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('padre, hijo, fk_estatus, created_by, modified_by', 'numerical', 'integerOnly' => true),
            array('descripcion, es_activo, created_date, modified_date, descripcion2', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_maestro, descripcion, padre, hijo, es_activo, fk_estatus, created_by, created_date, modified_by, modified_date, descripcion2', 'safe', 'on' => 'search'),
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
            'id_maestro' => 'Id Maestro',
            'descripcion' => 'Nacionalidad',
            'padre' => 'Padre',
            'hijo' => 'Hijo',
            'es_activo' => 'Es Activo',
            'fk_estatus' => 'Fk Estatus',
            'created_by' => 'Created By',
            'created_date' => 'Created Date',
            'modified_by' => 'Modified By',
            'modified_date' => 'Modified Date',
            'descripcion2' => 'Descripcion2',
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
        $criteria->compare('es_activo', $this->es_activo);
        $criteria->compare('fk_estatus', $this->fk_estatus);
        $criteria->compare('created_by', $this->created_by);
        $criteria->compare('created_date', $this->created_date, true);
        $criteria->compare('modified_by', $this->modified_by);
        $criteria->compare('modified_date', $this->modified_date, true);
        $criteria->compare('descripcion2', $this->descripcion2, true);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    public function FindMaestrosByPadreSelect($IdPadre, $Order = false) {
        $criteria = new CDbCriteria;
        if (!$Order) {
            $criteria->order = 't.descripcion ASC';
        } else {
            $criteria->order = $Order;
        }
        $criteria->addColumnCondition(array('t.padre' => $IdPadre,));
        $criteria->addColumnCondition(array('t.es_activo' => true,));
        $data = CHtml::listData(self::model()->findAll($criteria), 'id_maestro', 'descripcion');
        return $data;
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
