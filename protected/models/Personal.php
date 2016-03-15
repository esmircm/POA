<?php

/**
 * This is the model class for table "personal".
 *
 * The followings are the available columns in table 'personal':
 * @property integer $id_personal
 * @property integer $anios_servicio_apn
 * @property integer $cedula
 * @property integer $cedula_conyugue
 * @property integer $id_ciudad
 * @property integer $id_ciudad_nacimiento
 * @property integer $id_ciudad_residencia
 * @property string $diestralidad
 * @property string $direccion_residencia
 * @property string $doble_nacionalidad
 * @property string $email
 * @property integer $id_establecimiento_salud
 * @property string $estado_civil
 * @property double $estatura
 * @property string $fecha_nacimiento
 * @property string $fecha_nacionalizacion
 * @property string $gaceta_nacionalizacion
 * @property integer $grado_licencia
 * @property string $grupo_sanguineo
 * @property string $maneja
 * @property string $marca_vehiculo
 * @property string $mismo_organismo_conyugue
 * @property string $modelo_vehiculo
 * @property string $nacionalidad
 * @property string $nacionalizado
 * @property string $nivel_educativo
 * @property string $nombre_conyugue
 * @property string $numero_libreta_militar
 * @property string $numero_rif
 * @property string $numero_sso
 * @property string $otra_normativa_nac
 * @property integer $id_pais_nacionalidad
 * @property integer $id_parroquia
 * @property double $peso
 * @property string $placa_vehiculo
 * @property string $primer_apellido
 * @property string $primer_nombre
 * @property string $reingresable
 * @property string $sector_trabajo_conyugue
 * @property string $segundo_apellido
 * @property string $segundo_nombre
 * @property string $sexo
 * @property string $telefono_celular
 * @property string $telefono_oficina
 * @property string $telefono_residencia
 * @property string $tenencia_vivienda
 * @property string $tiene_hijos
 * @property string $tiene_vehiculo
 * @property string $tipo_vivienda
 * @property string $zona_postal_residencia
 * @property integer $id_sitp
 * @property string $tiempo_sitp
 * @property string $password
 * @property string $madre_padre
 * @property string $fecha_fallecimiento
 * @property integer $dias_servicio_apn
 * @property integer $meses_servicio_apn
 * @property string $deuda_regimen_derogado
 * @property string $credencial
 * @property string $puebloindigena
 * @property string $discapacidad
 * @property string $tipodiscapacidad
 *
 * The followings are the available model relations:
 * @property Parroquia $idParroquia
 * @property Ciudad $idCiudadResidencia
 * @property Ciudad $idCiudadNacimiento
 * @property Pais $idPaisNacionalidad
 * @property Estudio[] $estudios
 * @property Credencial[] $credencials
 * @property Educacion[] $educacions
 * @property Utiles[] $utiles
 * @property Trabajador[] $trabajadors
 * @property Siniestro[] $siniestros
 * @property Excepciontitular[] $excepciontitulars
 * @property Embargo[] $embargos
 * @property Excepcionbeneficiario[] $excepcionbeneficiarios
 * @property Apelacion[] $apelacions
 * @property Elegibleactividaddocente[] $elegibleactividaddocentes
 * @property Pagoguarderia[] $pagoguarderias
 * @property Historicodevengadointegral[] $historicodevengadointegrals
 * @property Titular[] $titulars
 * @property Beneficiario[] $beneficiarios
 * @property Guarderiafamiliar[] $guarderiafamiliars
 * @property Juguete[] $juguetes
 * @property Registrositp[] $registrositps
 * @property Historialorganismo[] $historialorganismos
 * @property Historialapn[] $historialapns
 * @property Anticipo[] $anticipos
 * @property Movimientoregistro[] $movimientoregistros
 * @property Movimientoscio[] $movimientoscios
 * @property Contrato[] $contratos
 * @property Habilidad[] $habilidads
 * @property Comisionservicioext[] $comisionservicioexts
 * @property Familiar[] $familiars
 * @property Historialremun[] $historialremuns
 * @property Servicioexterior[] $servicioexteriors
 * @property Antecedente[] $antecedentes
 * @property Reconocimiento[] $reconocimientos
 * @property Afiliacion[] $afiliacions
 * @property Idioma[] $idiomas
 * @property Encargaduria[] $encargadurias
 * @property Declaracion[] $declaracions
 * @property Averiguacion[] $averiguacions
 * @property Ausencia[] $ausencias
 * @property Experiencianoest[] $experiencianoests
 * @property Sancion[] $sancions
 * @property Profesiontrabajador[] $profesiontrabajadors
 * @property Personalorganismo[] $personalorganismos
 * @property Otraactividad[] $otraactividads
 * @property Experiencia[] $experiencias
 * @property Certificado[] $certificados
 * @property Comisionservicio[] $comisionservicios
 * @property Certificacion[] $certificacions
 * @property Actividaddocente[] $actividaddocentes
 */
class Personal extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'personal';
    }

    public $id_ciudad;

    
    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: Aqui Estan los Datos Requeridos
        // will receive user inputs.
        return array(
            array('email, id_personal, cedula, primer_nombre, primer_apellido, telefono_celular, direccion_residencia, zona_postal_residencia, estatura, peso, anios_servicio_apn', 'required'),
            array('id_personal, anios_servicio_apn, cedula, cedula_conyugue, id_ciudad_nacimiento, id_ciudad_residencia, id_ciudad, id_establecimiento_salud, grado_licencia, id_pais_nacionalidad, id_parroquia, id_sitp, dias_servicio_apn, meses_servicio_apn', 'numerical', 'integerOnly' => true),
            array('estatura, peso, telefono_oficina, telefono_residencia, telefono_celular', 'numerical'),
            array('diestralidad, doble_nacionalidad, estado_civil, maneja, mismo_organismo_conyugue, nacionalidad, nacionalizado, nivel_educativo, reingresable, sector_trabajo_conyugue, sexo, tenencia_vivienda, tiene_hijos, tiene_vehiculo, tipo_vivienda, madre_padre, deuda_regimen_derogado, discapacidad, tipodiscapacidad', 'length', 'max' => 1),
            
            array('telefono_oficina, telefono_residencia, telefono_celular', 'length', 'max' => 11,'min' => 11),
            //array('telefono_oficina, telefono_residencia, telefono_celular', 'length', ),
            
            array('direccion_residencia', 'length', 'max' => 100),
            array('email', 'length', 'max' => 60),
            array('gaceta_nacionalizacion, placa_vehiculo', 'length', 'max' => 10),
            array('grupo_sanguineo', 'length', 'max' => 3),
            array('marca_vehiculo, modelo_vehiculo, primer_apellido, primer_nombre, segundo_apellido, segundo_nombre, password', 'length', 'max' => 20),
            array('nombre_conyugue', 'length', 'max' => 50),
            array('numero_libreta_militar, numero_rif, numero_sso, telefono_celular, telefono_oficina, telefono_residencia, credencial', 'length', 'max' => 15),
            array('otra_normativa_nac', 'length', 'max' => 40),
            array('zona_postal_residencia, puebloindigena', 'length', 'max' => 6),
            array('fecha_nacionalizacion, tiempo_sitp, fecha_fallecimiento', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_personal, anios_servicio_apn, cedula, cedula_conyugue, id_ciudad_nacimiento, id_ciudad_residencia, id_ciudad, diestralidad, direccion_residencia, doble_nacionalidad, email, id_establecimiento_salud, estado_civil, estatura, fecha_nacimiento, fecha_nacionalizacion, gaceta_nacionalizacion, grado_licencia, grupo_sanguineo, maneja, marca_vehiculo, mismo_organismo_conyugue, modelo_vehiculo, nacionalidad, nacionalizado, nivel_educativo, nombre_conyugue, numero_libreta_militar, numero_rif, numero_sso, otra_normativa_nac, id_pais_nacionalidad, id_parroquia, peso, placa_vehiculo, primer_apellido, primer_nombre, reingresable, sector_trabajo_conyugue, segundo_apellido, segundo_nombre, sexo, telefono_celular, telefono_oficina, telefono_residencia, tenencia_vivienda, tiene_hijos, tiene_vehiculo, tipo_vivienda, zona_postal_residencia, id_sitp, tiempo_sitp, password, madre_padre, fecha_fallecimiento, dias_servicio_apn, meses_servicio_apn, deuda_regimen_derogado, credencial, puebloindigena, discapacidad, tipodiscapacidad', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'idParroquia' => array(self::BELONGS_TO, 'Parroquia', 'id_parroquia'),
            'idCiudad' => array(self::BELONGS_TO, 'Ciudad', 'id_ciudad'),
            'idCiudadResidencia' => array(self::BELONGS_TO, 'Ciudad', 'id_ciudad_residencia'),
            'idCiudadNacimiento' => array(self::BELONGS_TO, 'Ciudad', 'id_ciudad_nacimiento'),
            'idPaisNacionalidad' => array(self::BELONGS_TO, 'Pais', 'id_pais_nacionalidad'),
            'estudios' => array(self::HAS_MANY, 'Estudio', 'id_personal'),
            'credencials' => array(self::HAS_MANY, 'Credencial', 'id_personal'),
            'educacions' => array(self::HAS_MANY, 'Educacion', 'id_personal'),
            'utiles' => array(self::HAS_MANY, 'Utiles', 'id_personal'),
            'trabajadors' => array(self::HAS_MANY, 'Trabajador', 'id_personal'),
            'siniestros' => array(self::HAS_MANY, 'Siniestro', 'id_personal'),
            'excepciontitulars' => array(self::HAS_MANY, 'Excepciontitular', 'id_personal'),
            'embargos' => array(self::HAS_MANY, 'Embargo', 'id_personal'),
            'excepcionbeneficiarios' => array(self::HAS_MANY, 'Excepcionbeneficiario', 'id_personal'),
            'apelacions' => array(self::HAS_MANY, 'Apelacion', 'id_personal'),
            'elegibleactividaddocentes' => array(self::HAS_MANY, 'Elegibleactividaddocente', 'id_elegible'),
            'pagoguarderias' => array(self::HAS_MANY, 'Pagoguarderia', 'id_personal'),
            'historicodevengadointegrals' => array(self::HAS_MANY, 'Historicodevengadointegral', 'id_personal'),
            'titulars' => array(self::HAS_MANY, 'Titular', 'id_personal'),
            'beneficiarios' => array(self::HAS_MANY, 'Beneficiario', 'id_personal'),
            'guarderiafamiliars' => array(self::HAS_MANY, 'Guarderiafamiliar', 'id_personal'),
            'juguetes' => array(self::HAS_MANY, 'Juguete', 'id_personal'),
            'registrositps' => array(self::HAS_MANY, 'Registrositp', 'id_personal'),
            'historialorganismos' => array(self::HAS_MANY, 'Historialorganismo', 'id_personal'),
            'historialapns' => array(self::HAS_MANY, 'Historialapn', 'id_personal'),
            'anticipos' => array(self::HAS_MANY, 'Anticipo', 'id_personal'),
            'movimientoregistros' => array(self::HAS_MANY, 'Movimientoregistro', 'id_personal'),
            'movimientoscios' => array(self::HAS_MANY, 'Movimientoscio', 'id_personal'),
            'contratos' => array(self::HAS_MANY, 'Contrato', 'id_personal'),
            'habilidads' => array(self::HAS_MANY, 'Habilidad', 'id_personal'),
            'comisionservicioexts' => array(self::HAS_MANY, 'Comisionservicioext', 'id_personal'),
            'familiars' => array(self::HAS_MANY, 'Familiar', 'id_personal'),
            'historialremuns' => array(self::HAS_MANY, 'Historialremun', 'id_personal'),
            'servicioexteriors' => array(self::HAS_MANY, 'Servicioexterior', 'id_personal'),
            'antecedentes' => array(self::HAS_MANY, 'Antecedente', 'id_personal'),
            'reconocimientos' => array(self::HAS_MANY, 'Reconocimiento', 'id_personal'),
            'afiliacions' => array(self::HAS_MANY, 'Afiliacion', 'id_personal'),
            'idiomas' => array(self::HAS_MANY, 'Idioma', 'id_personal'),
            'encargadurias' => array(self::HAS_MANY, 'Encargaduria', 'id_personal'),
            'declaracions' => array(self::HAS_MANY, 'Declaracion', 'id_personal'),
            'averiguacions' => array(self::HAS_MANY, 'Averiguacion', 'id_personal'),
            'ausencias' => array(self::HAS_MANY, 'Ausencia', 'id_personal'),
            'experiencianoests' => array(self::HAS_MANY, 'Experiencianoest', 'id_personal'),
            'sancions' => array(self::HAS_MANY, 'Sancion', 'id_personal'),
            'profesiontrabajadors' => array(self::HAS_MANY, 'Profesiontrabajador', 'id_personal'),
            'personalorganismos' => array(self::HAS_MANY, 'Personalorganismo', 'id_personal'),
            'otraactividads' => array(self::HAS_MANY, 'Otraactividad', 'id_personal'),
            'experiencias' => array(self::HAS_MANY, 'Experiencia', 'id_personal'),
            'certificados' => array(self::HAS_MANY, 'Certificado', 'id_personal'),
            'comisionservicios' => array(self::HAS_MANY, 'Comisionservicio', 'id_personal'),
            'certificacions' => array(self::HAS_MANY, 'Certificacion', 'id_personal'),
            'actividaddocentes' => array(self::HAS_MANY, 'Actividaddocente', 'id_personal'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_personal' => 'Id Personal',
            'id_ciudad' => 'Ciudad',
            'pais2' => 'Pais',
            'anios_servicio_apn' => 'Años Servicio Administración Pública Nacional',
            'cedula' => 'Cedula',
            'cedula_conyugue' => 'Cedula Conyugue',
            'id_ciudad_nacimiento' => 'Ciudad de Nacimiento',
            'id_ciudad_residencia' => 'Ciudad de Residencia',
            'diestralidad' => 'Diestralidad',
            'direccion_residencia' => 'Direccion Residencia',
            'doble_nacionalidad' => 'Doble Nacionalidad',
            'email' => 'Correo Personal',
            'id_establecimiento_salud' => 'Id Establecimiento Salud',
            'estado_civil' => 'Estado Civil',
            'estatura' => 'Estatura',
            'fecha_nacimiento' => 'Fecha Nacimiento',
            'fecha_nacionalizacion' => 'Fecha Nacionalizacion',
            'gaceta_nacionalizacion' => 'Gaceta Nacionalizacion',
            'grado_licencia' => 'Grado Licencia',
            'grupo_sanguineo' => 'Grupo Sanguineo',
            'maneja' => 'Maneja',
            'marca_vehiculo' => 'Marca Vehiculo',
            'mismo_organismo_conyugue' => 'Mismo Organismo Conyugue',
            'modelo_vehiculo' => 'Modelo Vehiculo',
            'nacionalidad' => 'Nacionalidad',
            'nacionalizado' => 'Nacionalizado',
            'nivel_educativo' => 'Nivel Educativo',
            'nombre_conyugue' => 'Nombre Conyugue',
            'numero_libreta_militar' => 'Número Libreta Militar',
            'numero_rif' => 'Número Rif',
            'numero_sso' => 'Número SSO',
            'otra_normativa_nac' => 'Otra Normativa Nac',
            'id_pais_nacionalidad' => 'Id Pais Nacionalidad',
            'id_parroquia' => 'Id Parroquia',
            'peso' => 'Peso en Kilogramos',
            'placa_vehiculo' => 'Placa Vehiculo',
            'primer_apellido' => 'Primer Apellido',
            'primer_nombre' => 'Primer Nombre',
            'reingresable' => 'Reingresable',
            'sector_trabajo_conyugue' => 'Sector Trabajo Conyugue',
            'segundo_apellido' => 'Segundo Apellido',
            'segundo_nombre' => 'Segundo Nombre',
            'sexo' => 'Sexo',
            'telefono_celular' => 'Telefono Celular',
            'telefono_oficina' => 'Telefono Oficina',
            'telefono_residencia' => 'Telefono Residencia',
            'tenencia_vivienda' => 'Tenencia Vivienda',
            'tiene_hijos' => 'Tiene Hijos',
            'tiene_vehiculo' => 'Tiene Vehiculo',
            'tipo_vivienda' => 'Tipo Vivienda',
            'zona_postal_residencia' => 'Zona Postal Residencia',
            'id_sitp' => 'Id Sitp',
            'tiempo_sitp' => 'Tiempo Sitp',
            'password' => 'Password',
            'madre_padre' => 'Es Madre o Padre?',
            'fecha_fallecimiento' => 'Fecha Fallecimiento',
            'dias_servicio_apn' => 'Dias Servicio Apn',
            'meses_servicio_apn' => 'Meses Servicio Apn',
            'deuda_regimen_derogado' => 'Deuda Regimen Derogado',
            'credencial' => 'Credencial',
            'puebloindigena' => 'Puebloindigena',
            'discapacidad' => 'Posee alguna Discapacidad?',
            'tipodiscapacidad' => 'Tipodiscapacidad',
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
        $criteria->compare('id_ciudad', $this->id_ciudad);
        $criteria->compare('anios_servicio_apn', $this->anios_servicio_apn);
        $criteria->compare('cedula', $this->cedula);
        $criteria->compare('cedula_conyugue', $this->cedula_conyugue);
        $criteria->compare('id_ciudad_nacimiento', $this->id_ciudad_nacimiento);
        $criteria->compare('id_ciudad_residencia', $this->id_ciudad_residencia);
        $criteria->compare('diestralidad', $this->diestralidad, true);
        $criteria->compare('direccion_residencia', $this->direccion_residencia, true);
        $criteria->compare('doble_nacionalidad', $this->doble_nacionalidad, true);
        $criteria->compare('email', $this->email, true);
        $criteria->compare('id_establecimiento_salud', $this->id_establecimiento_salud);
        $criteria->compare('estado_civil', $this->estado_civil, true);
        $criteria->compare('estatura', $this->estatura);
        $criteria->compare('fecha_nacimiento', $this->fecha_nacimiento, true);
        $criteria->compare('fecha_nacionalizacion', $this->fecha_nacionalizacion, true);
        $criteria->compare('gaceta_nacionalizacion', $this->gaceta_nacionalizacion, true);
        $criteria->compare('grado_licencia', $this->grado_licencia);
        $criteria->compare('grupo_sanguineo', $this->grupo_sanguineo, true);
        $criteria->compare('maneja', $this->maneja, true);
        $criteria->compare('marca_vehiculo', $this->marca_vehiculo, true);
        $criteria->compare('mismo_organismo_conyugue', $this->mismo_organismo_conyugue, true);
        $criteria->compare('modelo_vehiculo', $this->modelo_vehiculo, true);
        $criteria->compare('nacionalidad', $this->nacionalidad, true);
        $criteria->compare('nacionalizado', $this->nacionalizado, true);
        $criteria->compare('nivel_educativo', $this->nivel_educativo, true);
        $criteria->compare('nombre_conyugue', $this->nombre_conyugue, true);
        $criteria->compare('numero_libreta_militar', $this->numero_libreta_militar, true);
        $criteria->compare('numero_rif', $this->numero_rif, true);
        $criteria->compare('numero_sso', $this->numero_sso, true);
        $criteria->compare('otra_normativa_nac', $this->otra_normativa_nac, true);
        $criteria->compare('id_pais_nacionalidad', $this->id_pais_nacionalidad);
        $criteria->compare('id_parroquia', $this->id_parroquia);
        $criteria->compare('peso', $this->peso);
        $criteria->compare('placa_vehiculo', $this->placa_vehiculo, true);
        $criteria->compare('primer_apellido', $this->primer_apellido, true);
        $criteria->compare('primer_nombre', $this->primer_nombre, true);
        $criteria->compare('reingresable', $this->reingresable, true);
        $criteria->compare('sector_trabajo_conyugue', $this->sector_trabajo_conyugue, true);
        $criteria->compare('segundo_apellido', $this->segundo_apellido, true);
        $criteria->compare('segundo_nombre', $this->segundo_nombre, true);
        $criteria->compare('sexo', $this->sexo, true);
        $criteria->compare('telefono_celular', $this->telefono_celular, true);
        $criteria->compare('telefono_oficina', $this->telefono_oficina, true);
        $criteria->compare('telefono_residencia', $this->telefono_residencia, true);
        $criteria->compare('tenencia_vivienda', $this->tenencia_vivienda, true);
        $criteria->compare('tiene_hijos', $this->tiene_hijos, true);
        $criteria->compare('tiene_vehiculo', $this->tiene_vehiculo, true);
        $criteria->compare('tipo_vivienda', $this->tipo_vivienda, true);
        $criteria->compare('zona_postal_residencia', $this->zona_postal_residencia, true);
        $criteria->compare('id_sitp', $this->id_sitp);
        $criteria->compare('tiempo_sitp', $this->tiempo_sitp, true);
        $criteria->compare('password', $this->password, true);
        $criteria->compare('madre_padre', $this->madre_padre, true);
        $criteria->compare('fecha_fallecimiento', $this->fecha_fallecimiento, true);
        $criteria->compare('dias_servicio_apn', $this->dias_servicio_apn);
        $criteria->compare('meses_servicio_apn', $this->meses_servicio_apn);
        $criteria->compare('deuda_regimen_derogado', $this->deuda_regimen_derogado, true);
        $criteria->compare('credencial', $this->credencial, true);
        $criteria->compare('puebloindigena', $this->puebloindigena, true);
        $criteria->compare('discapacidad', $this->discapacidad, true);
        $criteria->compare('tipodiscapacidad', $this->tipodiscapacidad, true);

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
     * @return Personal the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

}
