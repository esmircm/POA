<?php

/**
 * This is the model class for table "actualizar.vsw_usuarios_actualizados".
 *
 * The followings are the available columns in table 'actualizar.vsw_usuarios_actualizados':
 * @property integer $id_personal
 * @property integer $cedula
 * @property string $primer_nombre
 * @property string $primer_apellido
 * @property string $porcentaje
 * @property string $fecha
 */
class VswUsuariosActualizados extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'actualizar.vsw_usuarios_actualizados';
    }

    public function primaryKey() {
        return 'id_personal';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_personal, cedula', 'numerical', 'integerOnly' => true),
            array('primer_nombre, primer_apellido', 'length', 'max' => 20),
            array('porcentaje, fecha', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_personal, cedula, primer_nombre, primer_apellido, porcentaje, fecha', 'safe', 'on' => 'search'),
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
            'id_personal' => 'Id Personal',
            'cedula' => 'Cedula',
            'primer_nombre' => 'Primer Nombre',
            'primer_apellido' => 'Primer Apellido',
            'porcentaje' => 'Porcentaje',
            'fecha' => 'Fecha',
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

        $criteria->compare('id_personal', $this->id_personal);
        $criteria->compare('cedula', $this->cedula);
        $criteria->compare('primer_nombre', $this->primer_nombre, true);
        $criteria->compare('primer_apellido', $this->primer_apellido, true);
        $criteria->compare('porcentaje', $this->porcentaje, true);
        $criteria->compare('fecha', $this->fecha, true);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return VswUsuariosActualizados the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
