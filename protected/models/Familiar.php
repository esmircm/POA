<?php

/**
 * This is the model class for table "familiar".
 *
 * The followings are the available columns in table 'familiar':
 * @property integer $id_familiar
 * @property string $alergias
 * @property string $alergico
 * @property integer $cedula_familiar
 * @property string $estado_civil
 * @property string $fecha_nacimiento
 * @property string $goza_beca
 * @property string $goza_prima_por_hijo
 * @property string $goza_seguro
 * @property string $goza_utiles
 * @property string $grado
 * @property string $grupo_sanguineo
 * @property string $mismo_organismo
 * @property string $nino_excepcional
 * @property string $nivel_educativo
 * @property string $parentesco
 * @property string $sexo
 * @property string $talla_franela
 * @property string $talla_gorra
 * @property string $talla_pantalon
 * @property integer $id_personal
 * @property string $primer_nombre
 * @property string $segundo_nombre
 * @property string $primer_apellido
 * @property string $segundo_apellido
 * @property string $promedio_nota
 * @property integer $id_sitp
 * @property string $tiempo_sitp
 *
 * The followings are the available model relations:
 * @property Utiles[] $utiles
 * @property Excepcionbeneficiario[] $excepcionbeneficiarios
 * @property Pagoguarderia[] $pagoguarderias
 * @property Beneficiario[] $beneficiarios
 * @property Guarderiafamiliar[] $guarderiafamiliars
 * @property Personal $idPersonal
 */
class Familiar extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'familiar';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_familiar, fecha_nacimiento, id_personal, estado_civil, primer_nombre, primer_apellido, sexo, parentesco', 'required'),
            array('id_familiar, cedula_familiar, id_personal, id_sitp', 'numerical', 'integerOnly' => true),
            array('alergias', 'length', 'max' => 100),
            array('cedula_familiar', 'length', 'max' => 8),
            array('alergico, estado_civil, goza_beca, goza_prima_por_hijo, goza_seguro, goza_utiles, mismo_organismo, nino_excepcional, nivel_educativo, parentesco, sexo', 'length', 'max' => 1),
            array('grado, talla_franela, talla_gorra, talla_pantalon, promedio_nota', 'length', 'max' => 2),
            array('grupo_sanguineo', 'length', 'max' => 3),
            array('primer_nombre, segundo_nombre, primer_apellido, segundo_apellido', 'length', 'max' => 30),
            array('tiempo_sitp', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_familiar, alergias, alergico, cedula_familiar, estado_civil, fecha_nacimiento, goza_beca, goza_prima_por_hijo, goza_seguro, goza_utiles, grado, grupo_sanguineo, mismo_organismo, nino_excepcional, nivel_educativo, parentesco, sexo, talla_franela, talla_gorra, talla_pantalon, id_personal, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, promedio_nota, id_sitp, tiempo_sitp', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'utiles' => array(self::HAS_MANY, 'Utiles', 'id_familiar'),
            'excepcionbeneficiarios' => array(self::HAS_MANY, 'Excepcionbeneficiario', 'id_familiar'),
            'pagoguarderias' => array(self::HAS_MANY, 'Pagoguarderia', 'id_familiar'),
            'beneficiarios' => array(self::HAS_MANY, 'Beneficiario', 'id_familiar'),
            'guarderiafamiliars' => array(self::HAS_MANY, 'Guarderiafamiliar', 'id_familiar'),
            'idPersonal' => array(self::BELONGS_TO, 'Personal', 'id_personal'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_familiar' => 'Id Familiar',
            'alergias' => 'Alergias',
            'alergico' => 'Alérgico',
            'cedula_familiar' => 'Cédula del Familiar',
            'estado_civil' => 'Estado Civil',
            'fecha_nacimiento' => 'Fecha Nacimiento',
            'goza_beca' => 'Goza Beca',
            'goza_prima_por_hijo' => 'Goza Prima Por Hijo',
            'goza_seguro' => 'Goza Seguro',
            'goza_utiles' => 'Se le Entregan Utiles',
            'grado' => 'Ultimo Grado Cursado',
            'grupo_sanguineo' => 'Grupo Sanguineo',
            'mismo_organismo' => 'Trabaja en el mismo Organismo',
            'nino_excepcional' => 'Niño Excepcional',
            'nivel_educativo' => 'Nivel Educativo',
            'parentesco' => 'Parentesco',
            'sexo' => 'Sexo',
            'talla_franela' => 'Talla de Franela',
            'talla_gorra' => 'Talla de Gorra',
            'talla_pantalon' => 'Talla de Pantalón',
            'id_personal' => 'Id Personal',
            'primer_nombre' => 'Primer Nombre',
            'segundo_nombre' => 'Segundo Nombre',
            'primer_apellido' => 'Primer Apellido',
            'segundo_apellido' => 'Segundo Apellido',
            'promedio_nota' => 'Promedio de Notas',
            'id_sitp' => 'Id Sitp',
            'tiempo_sitp' => 'Tiempo Sitp',
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

        $criteria->compare('id_familiar', $this->id_familiar);
        $criteria->compare('alergias', $this->alergias, true);
        $criteria->compare('alergico', $this->alergico, true);
        $criteria->compare('cedula_familiar', $this->cedula_familiar);
        $criteria->compare('estado_civil', $this->estado_civil, true);
        $criteria->compare('fecha_nacimiento', $this->fecha_nacimiento, true);
        $criteria->compare('goza_beca', $this->goza_beca, true);
        $criteria->compare('goza_prima_por_hijo', $this->goza_prima_por_hijo, true);
        $criteria->compare('goza_seguro', $this->goza_seguro, true);
        $criteria->compare('goza_utiles', $this->goza_utiles, true);
        $criteria->compare('grado', $this->grado, true);
        $criteria->compare('grupo_sanguineo', $this->grupo_sanguineo, true);
        $criteria->compare('mismo_organismo', $this->mismo_organismo, true);
        $criteria->compare('nino_excepcional', $this->nino_excepcional, true);
        $criteria->compare('nivel_educativo', $this->nivel_educativo, true);
        $criteria->compare('parentesco', $this->parentesco, true);
        $criteria->compare('sexo', $this->sexo, true);
        $criteria->compare('talla_franela', $this->talla_franela, true);
        $criteria->compare('talla_gorra', $this->talla_gorra, true);
        $criteria->compare('talla_pantalon', $this->talla_pantalon, true);
        $criteria->compare('id_personal', $this->id_personal);
        $criteria->compare('primer_nombre', $this->primer_nombre, true);
        $criteria->compare('segundo_nombre', $this->segundo_nombre, true);
        $criteria->compare('primer_apellido', $this->primer_apellido, true);
        $criteria->compare('segundo_apellido', $this->segundo_apellido, true);
        $criteria->compare('promedio_nota', $this->promedio_nota, true);
        $criteria->compare('id_sitp', $this->id_sitp);
        $criteria->compare('tiempo_sitp', $this->tiempo_sitp, true);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

////        funcion que permite hacer la busqueda por id sobre el nivel educativo
//            public function FindBuscarByPadreSelect($IdNivelEducativo) {
//        $criteria = new CDbCriteria;
//        $data = CHtml::listData(self::model()->findAll($criteria), 'nivel_educativo', 'nivel_educativo');
//        return $data;
//    }

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
     * @return Familiar the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
