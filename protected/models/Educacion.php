<?php

/**
 * This is the model class for table "educacion".
 *
 * The followings are the available columns in table 'educacion':
 * @property integer $id_educacion
 * @property integer $anio_fin
 * @property integer $anio_inicio
 * @property integer $anios_experiencia
 * @property string $becado
 * @property integer $id_carrera
 * @property integer $id_titulo
 * @property string $estatus
 * @property string $sector
 * @property integer $meses_experiencia
 * @property integer $id_nivel_educativo
 * @property integer $id_ciudad
 * @property string $organizacion_becaria
 * @property integer $id_personal
 * @property string $registro_titulo
 * @property string $fecha_registro
 * @property string $reembolso
 * @property string $observaciones
 * @property string $nombre_entidad
 * @property string $nombre_postgrado
 * @property integer $id_sitp
 * @property string $tiempo_sitp
 * @property string $escala
 * @property string $calificacion
 * @property string $mencion
 *
 * The followings are the available model relations:
 * @property Personal $idPersonal
 * @property Niveleducativo $idNivelEducativo
 * @property Carrera $idCarrera
 * @property Titulo $idTitulo
 * @property Ciudad $idCiudad
 */
class Educacion extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'educacion';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('id_educacion, id_personal, anio_inicio, estatus, id_nivel_educativo ', 'required'),
            array('id_educacion, anio_fin, anio_inicio, anios_experiencia, id_carrera, id_titulo, meses_experiencia, id_nivel_educativo, id_ciudad, id_personal, id_sitp', 'numerical', 'integerOnly' => true),
            array('becado, estatus, sector, registro_titulo, reembolso', 'length', 'max' => 1),
            array('organizacion_becaria', 'length', 'max' => 100),
            array('nombre_entidad, nombre_postgrado', 'length', 'max' => 90),
            array('escala, calificacion', 'length', 'max' => 3),
            array('mencion', 'length', 'max' => 25),
            array('fecha_registro, observaciones, tiempo_sitp', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_educacion, anio_fin, anio_inicio, anios_experiencia, becado, id_carrera, id_titulo, estatus, sector, meses_experiencia, id_nivel_educativo, id_ciudad, organizacion_becaria, id_personal, registro_titulo, fecha_registro, reembolso, observaciones, nombre_entidad, nombre_postgrado, id_sitp, tiempo_sitp, escala, calificacion, mencion', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'idPersonal' => array(self::BELONGS_TO, 'Personal', 'id_personal'),
            'idNivelEducativo' => array(self::BELONGS_TO, 'Niveleducativo', 'id_nivel_educativo'),
            'idCarrera' => array(self::BELONGS_TO, 'Carrera', 'id_carrera'),
            'idTitulo' => array(self::BELONGS_TO, 'Titulo', 'id_titulo'),
            'idCiudad' => array(self::BELONGS_TO, 'Ciudad', 'id_ciudad'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_educacion' => 'id_educacion',
            'anio_fin' => 'Año Culminación',
            'anio_inicio' => 'Año Inicio',
            'anios_experiencia' => 'Anios Experiencia',
            'becado' => 'Becado',
            'id_carrera' => 'Carrera',
            'id_titulo' => 'Titulo Obtenido',
            'estatus' => 'Estatus',
            'sector' => 'Sector',
            'meses_experiencia' => 'Meses Experiencia',
            'id_nivel_educativo' => 'Último Nivel Educativo',
            'id_ciudad' => 'Ciudad',
            'organizacion_becaria' => 'Organizacion Becaria',
            'id_personal' => 'Id Personal',
            'registro_titulo' => 'Registro Titulo',
            'fecha_registro' => 'Fecha Registro',
            'reembolso' => 'Reembolso',
            'observaciones' => 'Observaciones',
            'nombre_entidad' => 'Entidad Educativa',
            'nombre_postgrado' => 'Nombre Postgrado',
            'id_sitp' => 'Id Sitp',
            'tiempo_sitp' => 'Tiempo Sitp',
            'escala' => 'Escala',
            'calificacion' => 'Calificacion',
            'mencion' => 'Mencion',
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

        $criteria->compare('id_educacion', $this->id_educacion);
        $criteria->compare('anio_fin', $this->anio_fin);
        $criteria->compare('anio_inicio', $this->anio_inicio);
        $criteria->compare('anios_experiencia', $this->anios_experiencia);
        $criteria->compare('becado', $this->becado, true);
        $criteria->compare('id_carrera', $this->id_carrera);
        $criteria->compare('id_titulo', $this->id_titulo);
        $criteria->compare('estatus', $this->estatus, true);
        $criteria->compare('sector', $this->sector, true);
        $criteria->compare('meses_experiencia', $this->meses_experiencia);
        $criteria->compare('id_nivel_educativo', $this->id_nivel_educativo);
        $criteria->compare('id_ciudad', $this->id_ciudad);
        $criteria->compare('organizacion_becaria', $this->organizacion_becaria, true);
        $criteria->compare('id_personal', $this->id_personal);
        $criteria->compare('registro_titulo', $this->registro_titulo, true);
        $criteria->compare('fecha_registro', $this->fecha_registro, true);
        $criteria->compare('reembolso', $this->reembolso, true);
        $criteria->compare('observaciones', $this->observaciones, true);
        $criteria->compare('nombre_entidad', $this->nombre_entidad, true);
        $criteria->compare('nombre_postgrado', $this->nombre_postgrado, true);
        $criteria->compare('id_sitp', $this->id_sitp);
        $criteria->compare('tiempo_sitp', $this->tiempo_sitp, true);
        $criteria->compare('escala', $this->escala, true);
        $criteria->compare('calificacion', $this->calificacion, true);
        $criteria->compare('mencion', $this->mencion, true);

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
     * @return Educacion the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
