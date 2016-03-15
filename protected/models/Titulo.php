<?php

/**
 * This is the model class for table "titulo".
 *
 * The followings are the available columns in table 'titulo':
 * @property integer $id_titulo
 * @property string $cod_titulo
 * @property integer $id_nivel_educativo
 * @property integer $id_grupo_profesion
 * @property string $descripcion
 *
 * The followings are the available model relations:
 * @property Educacion[] $educacions
 * @property Niveleducativo $idNivelEducativo
 * @property Grupoprofesion $idGrupoProfesion
 */
class Titulo extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'titulo';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_titulo, id_nivel_educativo, id_grupo_profesion', 'required'),
            array('id_titulo, id_nivel_educativo, id_grupo_profesion', 'numerical', 'integerOnly' => true),
            array('cod_titulo', 'length', 'max' => 6),
            array('descripcion', 'length', 'max' => 90),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_titulo, cod_titulo, id_nivel_educativo, id_grupo_profesion, descripcion', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'educacions' => array(self::HAS_MANY, 'Educacion', 'id_titulo'),
            'idNivelEducativo' => array(self::BELONGS_TO, 'Niveleducativo', 'id_nivel_educativo'),
            'idGrupoProfesion' => array(self::BELONGS_TO, 'Grupoprofesion', 'id_grupo_profesion'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_titulo' => 'Id Titulo',
            'cod_titulo' => 'Cod Titulo',
            'id_nivel_educativo' => 'Id Nivel Educativo',
            'id_grupo_profesion' => 'Id Grupo Profesion',
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

        $criteria->compare('id_titulo', $this->id_titulo);
        $criteria->compare('cod_titulo', $this->cod_titulo, true);
        $criteria->compare('id_nivel_educativo', $this->id_nivel_educativo);
        $criteria->compare('id_grupo_profesion', $this->id_grupo_profesion);
        $criteria->compare('descripcion', $this->descripcion, true);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
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
     * @return Titulo the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
