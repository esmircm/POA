<?php

/**
 * This is the model class for table "trabajador".
 *
 * The followings are the available columns in table 'trabajador':
 * @property integer $id_trabajador
 * @property integer $id_personal
 * @property integer $id_tipo_personal
 * @property integer $cedula
 * @property string $cod_tipo_personal
 * @property string $estatus
 * @property string $movimiento
 * @property string $situacion
 * @property integer $id_registro_cargos
 * @property integer $id_cargo
 * @property integer $id_detalle_tabulador_med
 * @property integer $id_dependencia
 * @property integer $id_lugar_pago
 * @property integer $codigo_nomina
 * @property string $cod_cargo
 * @property double $sueldo_basico
 * @property integer $paso
 * @property integer $id_turno
 * @property string $riesgo
 * @property string $regimen
 * @property string $fecha_ingreso
 * @property string $fecha_ingreso_apn
 * @property string $fecha_vacaciones
 * @property string $fecha_prestaciones
 * @property string $fecha_antiguedad
 * @property string $fecha_egreso
 * @property string $fecha_jubilacion
 * @property string $forma_pago
 * @property integer $id_banco_nomina
 * @property string $tipo_cta_nomina
 * @property string $cuenta_nomina
 * @property integer $id_banco_lph
 * @property string $cuenta_lph
 * @property integer $id_banco_fid
 * @property string $cuenta_fid
 * @property double $porcentaje_islr
 * @property string $cotiza_sso
 * @property string $cotiza_spf
 * @property string $cotiza_lph
 * @property string $cotiza_fju
 * @property string $ded_prox_nomina
 * @property string $par_prox_nomina
 * @property double $porcentaje_jubilacion
 * @property double $base_jubilacion
 * @property string $fe_vida
 * @property integer $id_causa_movimiento
 * @property integer $id_dependencia_real
 * @property integer $id_cargo_real
 * @property integer $id_organismo
 * @property integer $mes_ingreso
 * @property integer $dia_ingreso
 * @property integer $anio_ingreso
 * @property integer $mes_ingreso_apn
 * @property integer $dia_ingreso_apn
 * @property integer $anio_ingreso_apn
 * @property integer $mes_vacaciones
 * @property integer $dia_vacaciones
 * @property integer $anio_vacaciones
 * @property integer $mes_prestaciones
 * @property integer $dia_prestaciones
 * @property integer $anio_prestaciones
 * @property integer $mes_antiguedad
 * @property integer $dia_antiguedad
 * @property integer $anio_antiguedad
 * @property integer $mes_jubilacion
 * @property integer $dia_jubilacion
 * @property integer $anio_jubilacion
 * @property integer $mes_egreso
 * @property integer $dia_egreso
 * @property integer $anio_egreso
 * @property string $fecha_entrada_sig
 * @property string $fecha_salida_sig
 * @property integer $codigo_nomina_real
 * @property string $cod_organismo_adscrito
 * @property integer $lunes_primera
 * @property integer $lunes_segunda
 * @property integer $lunes_retroactivo
 * @property string $hay_retroactivo
 * @property integer $dias_trabajados
 * @property integer $mes_entrada
 * @property integer $dia_entrada
 * @property integer $anio_entrada
 * @property integer $mes_salida
 * @property integer $dia_salida
 * @property integer $anio_salida
 * @property double $horas_semanales
 * @property string $fecha_ingreso_cargo
 * @property integer $mes_ingreso_cargo
 * @property integer $dia_ingreso_cargo
 * @property integer $anio_ingreso_cargo
 * @property string $fecha_fe_vida
 * @property string $fecha_encargaduria
 * @property string $fecha_comision_servicio
 * @property string $organismo_comision_servicio
 * @property string $fecha_tipo_personal
 * @property string $fecha_ultimo_movimiento
 * @property string $codigo_patronal
 * @property string $jubilacion_planificada
 *
 * The followings are the available model relations:
 * @property Registrodocente[] $registrodocentes
 * @property Cajaahorro[] $cajaahorros
 * @property Calculobonofinanio[] $calculobonofinanios
 * @property Trabajadorasignatura[] $trabajadorasignaturas
 * @property Personal $idPersonal
 * @property Dependencia $idDependencia
 * @property Lugarpago $idLugarPago
 * @property Turno $idTurno
 * @property Causamovimiento $idCausaMovimiento
 * @property Dependencia $idDependenciaReal
 * @property Cargo $idCargoReal
 * @property Tipopersonal $idTipoPersonal
 * @property Banco $idBancoNomina
 * @property Banco $idBancoLph
 * @property Banco $idBancoF
 * @property Registrocargos $idRegistroCargos
 * @property Organismo $idOrganismo
 * @property Cargo $idCargo
 * @property Dotaciontrabajador[] $dotaciontrabajadors
 * @property Planillaarc[] $planillaarcs
 * @property Nominadiplomatico[] $nominadiplomaticos
 * @property Nominaconversion[] $nominaconversions
 * @property Resumenviejoregimen[] $resumenviejoregimens
 * @property Interesviejoregimen[] $interesviejoregimens
 * @property Interesadicional[] $interesadicionals
 * @property Resumennuevoregimen[] $resumennuevoregimens
 * @property Interesnuevoregimen[] $interesnuevoregimens
 * @property Conceptodiplomatico[] $conceptodiplomaticos
 * @property Liquidacionresumennuevoregimen[] $liquidacionresumennuevoregimens
 * @property Liquidacioninteresnuevoregimen[] $liquidacioninteresnuevoregimens
 * @property Liquidacionresumenviejoregimen[] $liquidacionresumenviejoregimens
 * @property Liquidacioninteresadicional[] $liquidacioninteresadicionals
 * @property Liquidacioninteresviejoregimen[] $liquidacioninteresviejoregimens
 * @property Conceptoliquidacion[] $conceptoliquidacions
 * @property Mesesjubilacion[] $mesesjubilacions
 * @property Historicoticket[] $historicotickets
 * @property Calculoticket[] $calculotickets
 * @property Excepcionticket[] $excepciontickets
 * @property Retroactivoticket[] $retroactivotickets
 * @property Aumentoevaluacion[] $aumentoevaluacions
 * @property Conceptomovimiento[] $conceptomovimientos
 * @property Aplicartabulador[] $aplicartabuladors
 * @property Trabajadorespecifica[] $trabajadorespecificas
 * @property Planillaari[] $planillaaris
 * @property Calculovacacional[] $calculovacacionals
 * @property Otrasalicuotas[] $otrasalicuotases
 * @property Prestamo[] $prestamos
 * @property Sueldopromedio[] $sueldopromedios
 * @property Conceptovariable[] $conceptovariables
 * @property Calculoantiguedad[] $calculoantiguedads
 * @property Registrocargos[] $registrocargoses
 * @property Conceptofijo[] $conceptofijos
 */
class Trabajador extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'trabajador';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id_trabajador, id_personal, id_tipo_personal, id_cargo, id_dependencia, id_organismo', 'required'),
			array('id_trabajador, id_personal, id_tipo_personal, cedula, id_registro_cargos, id_cargo, id_detalle_tabulador_med, id_dependencia, id_lugar_pago, codigo_nomina, paso, id_turno, id_banco_nomina, id_banco_lph, id_banco_fid, id_causa_movimiento, id_dependencia_real, id_cargo_real, id_organismo, mes_ingreso, dia_ingreso, anio_ingreso, mes_ingreso_apn, dia_ingreso_apn, anio_ingreso_apn, mes_vacaciones, dia_vacaciones, anio_vacaciones, mes_prestaciones, dia_prestaciones, anio_prestaciones, mes_antiguedad, dia_antiguedad, anio_antiguedad, mes_jubilacion, dia_jubilacion, anio_jubilacion, mes_egreso, dia_egreso, anio_egreso, codigo_nomina_real, lunes_primera, lunes_segunda, lunes_retroactivo, dias_trabajados, mes_entrada, dia_entrada, anio_entrada, mes_salida, dia_salida, anio_salida, mes_ingreso_cargo, dia_ingreso_cargo, anio_ingreso_cargo', 'numerical', 'integerOnly'=>true),
			array('sueldo_basico, porcentaje_islr, porcentaje_jubilacion, base_jubilacion, horas_semanales', 'numerical'),
			array('cod_tipo_personal, situacion', 'length', 'max'=>2),
			array('estatus, movimiento, riesgo, regimen, forma_pago, tipo_cta_nomina, cotiza_sso, cotiza_spf, cotiza_lph, cotiza_fju, ded_prox_nomina, par_prox_nomina, fe_vida, hay_retroactivo, jubilacion_planificada', 'length', 'max'=>1),
			array('cod_cargo', 'length', 'max'=>8),
			array('cuenta_nomina, cuenta_lph, cuenta_fid', 'length', 'max'=>20),
			array('cod_organismo_adscrito, codigo_patronal', 'length', 'max'=>10),
			array('organismo_comision_servicio', 'length', 'max'=>60),
			array('fecha_ingreso, fecha_ingreso_apn, fecha_vacaciones, fecha_prestaciones, fecha_antiguedad, fecha_egreso, fecha_jubilacion, fecha_entrada_sig, fecha_salida_sig, fecha_ingreso_cargo, fecha_fe_vida, fecha_encargaduria, fecha_comision_servicio, fecha_tipo_personal, fecha_ultimo_movimiento', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id_trabajador, id_personal, id_tipo_personal, cedula, cod_tipo_personal, estatus, movimiento, situacion, id_registro_cargos, id_cargo, id_detalle_tabulador_med, id_dependencia, id_lugar_pago, codigo_nomina, cod_cargo, sueldo_basico, paso, id_turno, riesgo, regimen, fecha_ingreso, fecha_ingreso_apn, fecha_vacaciones, fecha_prestaciones, fecha_antiguedad, fecha_egreso, fecha_jubilacion, forma_pago, id_banco_nomina, tipo_cta_nomina, cuenta_nomina, id_banco_lph, cuenta_lph, id_banco_fid, cuenta_fid, porcentaje_islr, cotiza_sso, cotiza_spf, cotiza_lph, cotiza_fju, ded_prox_nomina, par_prox_nomina, porcentaje_jubilacion, base_jubilacion, fe_vida, id_causa_movimiento, id_dependencia_real, id_cargo_real, id_organismo, mes_ingreso, dia_ingreso, anio_ingreso, mes_ingreso_apn, dia_ingreso_apn, anio_ingreso_apn, mes_vacaciones, dia_vacaciones, anio_vacaciones, mes_prestaciones, dia_prestaciones, anio_prestaciones, mes_antiguedad, dia_antiguedad, anio_antiguedad, mes_jubilacion, dia_jubilacion, anio_jubilacion, mes_egreso, dia_egreso, anio_egreso, fecha_entrada_sig, fecha_salida_sig, codigo_nomina_real, cod_organismo_adscrito, lunes_primera, lunes_segunda, lunes_retroactivo, hay_retroactivo, dias_trabajados, mes_entrada, dia_entrada, anio_entrada, mes_salida, dia_salida, anio_salida, horas_semanales, fecha_ingreso_cargo, mes_ingreso_cargo, dia_ingreso_cargo, anio_ingreso_cargo, fecha_fe_vida, fecha_encargaduria, fecha_comision_servicio, organismo_comision_servicio, fecha_tipo_personal, fecha_ultimo_movimiento, codigo_patronal, jubilacion_planificada', 'safe', 'on'=>'search'),
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
			'registrodocentes' => array(self::HAS_MANY, 'Registrodocente', 'id_trabajador'),
			'cajaahorros' => array(self::HAS_MANY, 'Cajaahorro', 'id_trabajador'),
			'calculobonofinanios' => array(self::HAS_MANY, 'Calculobonofinanio', 'id_trabajador'),
			'trabajadorasignaturas' => array(self::HAS_MANY, 'Trabajadorasignatura', 'id_trabajador'),
			'idPersonal' => array(self::BELONGS_TO, 'Personal', 'id_personal'),
			'idDependencia' => array(self::BELONGS_TO, 'Dependencia', 'id_dependencia'),
			'idLugarPago' => array(self::BELONGS_TO, 'Lugarpago', 'id_lugar_pago'),
			'idTurno' => array(self::BELONGS_TO, 'Turno', 'id_turno'),
			'idCausaMovimiento' => array(self::BELONGS_TO, 'Causamovimiento', 'id_causa_movimiento'),
			'idDependenciaReal' => array(self::BELONGS_TO, 'Dependencia', 'id_dependencia_real'),
			'idCargoReal' => array(self::BELONGS_TO, 'Cargo', 'id_cargo_real'),
			'idTipoPersonal' => array(self::BELONGS_TO, 'Tipopersonal', 'id_tipo_personal'),
			'idBancoNomina' => array(self::BELONGS_TO, 'Banco', 'id_banco_nomina'),
			'idBancoLph' => array(self::BELONGS_TO, 'Banco', 'id_banco_lph'),
			'idBancoF' => array(self::BELONGS_TO, 'Banco', 'id_banco_fid'),
			'idRegistroCargos' => array(self::BELONGS_TO, 'Registrocargos', 'id_registro_cargos'),
			'idOrganismo' => array(self::BELONGS_TO, 'Organismo', 'id_organismo'),
			'idCargo' => array(self::BELONGS_TO, 'Cargo', 'id_cargo'),
			'dotaciontrabajadors' => array(self::HAS_MANY, 'Dotaciontrabajador', 'id_trabajador'),
			'planillaarcs' => array(self::HAS_MANY, 'Planillaarc', 'id_trabajador'),
			'nominadiplomaticos' => array(self::HAS_MANY, 'Nominadiplomatico', 'id_trabajador'),
			'nominaconversions' => array(self::HAS_MANY, 'Nominaconversion', 'id_trabajador'),
			'resumenviejoregimens' => array(self::HAS_MANY, 'Resumenviejoregimen', 'id_trabajador'),
			'interesviejoregimens' => array(self::HAS_MANY, 'Interesviejoregimen', 'id_trabajador'),
			'interesadicionals' => array(self::HAS_MANY, 'Interesadicional', 'id_trabajador'),
			'resumennuevoregimens' => array(self::HAS_MANY, 'Resumennuevoregimen', 'id_trabajador'),
			'interesnuevoregimens' => array(self::HAS_MANY, 'Interesnuevoregimen', 'id_trabajador'),
			'conceptodiplomaticos' => array(self::HAS_MANY, 'Conceptodiplomatico', 'id_trabajador'),
			'liquidacionresumennuevoregimens' => array(self::HAS_MANY, 'Liquidacionresumennuevoregimen', 'id_trabajador'),
			'liquidacioninteresnuevoregimens' => array(self::HAS_MANY, 'Liquidacioninteresnuevoregimen', 'id_trabajador'),
			'liquidacionresumenviejoregimens' => array(self::HAS_MANY, 'Liquidacionresumenviejoregimen', 'id_trabajador'),
			'liquidacioninteresadicionals' => array(self::HAS_MANY, 'Liquidacioninteresadicional', 'id_trabajador'),
			'liquidacioninteresviejoregimens' => array(self::HAS_MANY, 'Liquidacioninteresviejoregimen', 'id_trabajador'),
			'conceptoliquidacions' => array(self::HAS_MANY, 'Conceptoliquidacion', 'id_trabajador'),
			'mesesjubilacions' => array(self::HAS_MANY, 'Mesesjubilacion', 'id_trabajador'),
			'historicotickets' => array(self::HAS_MANY, 'Historicoticket', 'id_trabajador'),
			'calculotickets' => array(self::HAS_MANY, 'Calculoticket', 'id_trabajador'),
			'excepciontickets' => array(self::HAS_MANY, 'Excepcionticket', 'id_trabajador'),
			'retroactivotickets' => array(self::HAS_MANY, 'Retroactivoticket', 'id_trabajador'),
			'aumentoevaluacions' => array(self::HAS_MANY, 'Aumentoevaluacion', 'id_trabajador'),
			'conceptomovimientos' => array(self::HAS_MANY, 'Conceptomovimiento', 'id_trabajador'),
			'aplicartabuladors' => array(self::HAS_MANY, 'Aplicartabulador', 'id_trabajador'),
			'trabajadorespecificas' => array(self::HAS_MANY, 'Trabajadorespecifica', 'id_trabajador'),
			'planillaaris' => array(self::HAS_MANY, 'Planillaari', 'id_trabajador'),
			'calculovacacionals' => array(self::HAS_MANY, 'Calculovacacional', 'id_trabajador'),
			'otrasalicuotases' => array(self::HAS_MANY, 'Otrasalicuotas', 'id_trabajador'),
			'prestamos' => array(self::HAS_MANY, 'Prestamo', 'id_trabajador'),
			'sueldopromedios' => array(self::HAS_MANY, 'Sueldopromedio', 'id_trabajador'),
			'conceptovariables' => array(self::HAS_MANY, 'Conceptovariable', 'id_trabajador'),
			'calculoantiguedads' => array(self::HAS_MANY, 'Calculoantiguedad', 'id_trabajador'),
			'registrocargoses' => array(self::HAS_MANY, 'Registrocargos', 'id_trabajador'),
			'conceptofijos' => array(self::HAS_MANY, 'Conceptofijo', 'id_trabajador'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id_trabajador' => 'Id Trabajador',
			'id_personal' => 'Id Personal',
			'id_tipo_personal' => 'Id Tipo Personal',
			'cedula' => 'Cedula',
			'cod_tipo_personal' => 'Cod Tipo Personal',
			'estatus' => 'Estatus',
			'movimiento' => 'Movimiento',
			'situacion' => 'Situacion',
			'id_registro_cargos' => 'Id Registro Cargos',
			'id_cargo' => 'Id Cargo',
			'id_detalle_tabulador_med' => 'Id Detalle Tabulador Med',
			'id_dependencia' => 'Id Dependencia',
			'id_lugar_pago' => 'Id Lugar Pago',
			'codigo_nomina' => 'Codigo Nomina',
			'cod_cargo' => 'Cod Cargo',
			'sueldo_basico' => 'Sueldo Basico',
			'paso' => 'Paso',
			'id_turno' => 'Id Turno',
			'riesgo' => 'Riesgo',
			'regimen' => 'Regimen',
			'fecha_ingreso' => 'Fecha Ingreso',
			'fecha_ingreso_apn' => 'Fecha Ingreso Apn',
			'fecha_vacaciones' => 'Fecha Vacaciones',
			'fecha_prestaciones' => 'Fecha Prestaciones',
			'fecha_antiguedad' => 'Fecha Antiguedad',
			'fecha_egreso' => 'Fecha Egreso',
			'fecha_jubilacion' => 'Fecha Jubilacion',
			'forma_pago' => 'Forma Pago',
			'id_banco_nomina' => 'Id Banco Nomina',
			'tipo_cta_nomina' => 'Tipo Cta Nomina',
			'cuenta_nomina' => 'Cuenta Nomina',
			'id_banco_lph' => 'Id Banco Lph',
			'cuenta_lph' => 'Cuenta Lph',
			'id_banco_fid' => 'Id Banco Fid',
			'cuenta_fid' => 'Cuenta Fid',
			'porcentaje_islr' => 'Porcentaje Islr',
			'cotiza_sso' => 'Cotiza Sso',
			'cotiza_spf' => 'Cotiza Spf',
			'cotiza_lph' => 'Cotiza Lph',
			'cotiza_fju' => 'Cotiza Fju',
			'ded_prox_nomina' => 'Ded Prox Nomina',
			'par_prox_nomina' => 'Par Prox Nomina',
			'porcentaje_jubilacion' => 'Porcentaje Jubilacion',
			'base_jubilacion' => 'Base Jubilacion',
			'fe_vida' => 'Fe Vida',
			'id_causa_movimiento' => 'Id Causa Movimiento',
			'id_dependencia_real' => 'Id Dependencia Real',
			'id_cargo_real' => 'Id Cargo Real',
			'id_organismo' => 'Id Organismo',
			'mes_ingreso' => 'Mes Ingreso',
			'dia_ingreso' => 'Dia Ingreso',
			'anio_ingreso' => 'Anio Ingreso',
			'mes_ingreso_apn' => 'Mes Ingreso Apn',
			'dia_ingreso_apn' => 'Dia Ingreso Apn',
			'anio_ingreso_apn' => 'Anio Ingreso Apn',
			'mes_vacaciones' => 'Mes Vacaciones',
			'dia_vacaciones' => 'Dia Vacaciones',
			'anio_vacaciones' => 'Anio Vacaciones',
			'mes_prestaciones' => 'Mes Prestaciones',
			'dia_prestaciones' => 'Dia Prestaciones',
			'anio_prestaciones' => 'Anio Prestaciones',
			'mes_antiguedad' => 'Mes Antiguedad',
			'dia_antiguedad' => 'Dia Antiguedad',
			'anio_antiguedad' => 'Anio Antiguedad',
			'mes_jubilacion' => 'Mes Jubilacion',
			'dia_jubilacion' => 'Dia Jubilacion',
			'anio_jubilacion' => 'Anio Jubilacion',
			'mes_egreso' => 'Mes Egreso',
			'dia_egreso' => 'Dia Egreso',
			'anio_egreso' => 'Anio Egreso',
			'fecha_entrada_sig' => 'Fecha Entrada Sig',
			'fecha_salida_sig' => 'Fecha Salida Sig',
			'codigo_nomina_real' => 'Codigo Nomina Real',
			'cod_organismo_adscrito' => 'Cod Organismo Adscrito',
			'lunes_primera' => 'Lunes Primera',
			'lunes_segunda' => 'Lunes Segunda',
			'lunes_retroactivo' => 'Lunes Retroactivo',
			'hay_retroactivo' => 'Hay Retroactivo',
			'dias_trabajados' => 'Dias Trabajados',
			'mes_entrada' => 'Mes Entrada',
			'dia_entrada' => 'Dia Entrada',
			'anio_entrada' => 'Anio Entrada',
			'mes_salida' => 'Mes Salida',
			'dia_salida' => 'Dia Salida',
			'anio_salida' => 'Anio Salida',
			'horas_semanales' => 'Horas Semanales',
			'fecha_ingreso_cargo' => 'Fecha Ingreso Cargo',
			'mes_ingreso_cargo' => 'Mes Ingreso Cargo',
			'dia_ingreso_cargo' => 'Dia Ingreso Cargo',
			'anio_ingreso_cargo' => 'Anio Ingreso Cargo',
			'fecha_fe_vida' => 'Fecha Fe Vida',
			'fecha_encargaduria' => 'Fecha Encargaduria',
			'fecha_comision_servicio' => 'Fecha Comision Servicio',
			'organismo_comision_servicio' => 'Organismo Comision Servicio',
			'fecha_tipo_personal' => 'Fecha Tipo Personal',
			'fecha_ultimo_movimiento' => 'Fecha Ultimo Movimiento',
			'codigo_patronal' => 'Codigo Patronal',
			'jubilacion_planificada' => 'Jubilacion Planificada',
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

		$criteria->compare('id_trabajador',$this->id_trabajador);
		$criteria->compare('id_personal',$this->id_personal);
		$criteria->compare('id_tipo_personal',$this->id_tipo_personal);
		$criteria->compare('cedula',$this->cedula);
		$criteria->compare('cod_tipo_personal',$this->cod_tipo_personal,true);
		$criteria->compare('estatus',$this->estatus,true);
		$criteria->compare('movimiento',$this->movimiento,true);
		$criteria->compare('situacion',$this->situacion,true);
		$criteria->compare('id_registro_cargos',$this->id_registro_cargos);
		$criteria->compare('id_cargo',$this->id_cargo);
		$criteria->compare('id_detalle_tabulador_med',$this->id_detalle_tabulador_med);
		$criteria->compare('id_dependencia',$this->id_dependencia);
		$criteria->compare('id_lugar_pago',$this->id_lugar_pago);
		$criteria->compare('codigo_nomina',$this->codigo_nomina);
		$criteria->compare('cod_cargo',$this->cod_cargo,true);
		$criteria->compare('sueldo_basico',$this->sueldo_basico);
		$criteria->compare('paso',$this->paso);
		$criteria->compare('id_turno',$this->id_turno);
		$criteria->compare('riesgo',$this->riesgo,true);
		$criteria->compare('regimen',$this->regimen,true);
		$criteria->compare('fecha_ingreso',$this->fecha_ingreso,true);
		$criteria->compare('fecha_ingreso_apn',$this->fecha_ingreso_apn,true);
		$criteria->compare('fecha_vacaciones',$this->fecha_vacaciones,true);
		$criteria->compare('fecha_prestaciones',$this->fecha_prestaciones,true);
		$criteria->compare('fecha_antiguedad',$this->fecha_antiguedad,true);
		$criteria->compare('fecha_egreso',$this->fecha_egreso,true);
		$criteria->compare('fecha_jubilacion',$this->fecha_jubilacion,true);
		$criteria->compare('forma_pago',$this->forma_pago,true);
		$criteria->compare('id_banco_nomina',$this->id_banco_nomina);
		$criteria->compare('tipo_cta_nomina',$this->tipo_cta_nomina,true);
		$criteria->compare('cuenta_nomina',$this->cuenta_nomina,true);
		$criteria->compare('id_banco_lph',$this->id_banco_lph);
		$criteria->compare('cuenta_lph',$this->cuenta_lph,true);
		$criteria->compare('id_banco_fid',$this->id_banco_fid);
		$criteria->compare('cuenta_fid',$this->cuenta_fid,true);
		$criteria->compare('porcentaje_islr',$this->porcentaje_islr);
		$criteria->compare('cotiza_sso',$this->cotiza_sso,true);
		$criteria->compare('cotiza_spf',$this->cotiza_spf,true);
		$criteria->compare('cotiza_lph',$this->cotiza_lph,true);
		$criteria->compare('cotiza_fju',$this->cotiza_fju,true);
		$criteria->compare('ded_prox_nomina',$this->ded_prox_nomina,true);
		$criteria->compare('par_prox_nomina',$this->par_prox_nomina,true);
		$criteria->compare('porcentaje_jubilacion',$this->porcentaje_jubilacion);
		$criteria->compare('base_jubilacion',$this->base_jubilacion);
		$criteria->compare('fe_vida',$this->fe_vida,true);
		$criteria->compare('id_causa_movimiento',$this->id_causa_movimiento);
		$criteria->compare('id_dependencia_real',$this->id_dependencia_real);
		$criteria->compare('id_cargo_real',$this->id_cargo_real);
		$criteria->compare('id_organismo',$this->id_organismo);
		$criteria->compare('mes_ingreso',$this->mes_ingreso);
		$criteria->compare('dia_ingreso',$this->dia_ingreso);
		$criteria->compare('anio_ingreso',$this->anio_ingreso);
		$criteria->compare('mes_ingreso_apn',$this->mes_ingreso_apn);
		$criteria->compare('dia_ingreso_apn',$this->dia_ingreso_apn);
		$criteria->compare('anio_ingreso_apn',$this->anio_ingreso_apn);
		$criteria->compare('mes_vacaciones',$this->mes_vacaciones);
		$criteria->compare('dia_vacaciones',$this->dia_vacaciones);
		$criteria->compare('anio_vacaciones',$this->anio_vacaciones);
		$criteria->compare('mes_prestaciones',$this->mes_prestaciones);
		$criteria->compare('dia_prestaciones',$this->dia_prestaciones);
		$criteria->compare('anio_prestaciones',$this->anio_prestaciones);
		$criteria->compare('mes_antiguedad',$this->mes_antiguedad);
		$criteria->compare('dia_antiguedad',$this->dia_antiguedad);
		$criteria->compare('anio_antiguedad',$this->anio_antiguedad);
		$criteria->compare('mes_jubilacion',$this->mes_jubilacion);
		$criteria->compare('dia_jubilacion',$this->dia_jubilacion);
		$criteria->compare('anio_jubilacion',$this->anio_jubilacion);
		$criteria->compare('mes_egreso',$this->mes_egreso);
		$criteria->compare('dia_egreso',$this->dia_egreso);
		$criteria->compare('anio_egreso',$this->anio_egreso);
		$criteria->compare('fecha_entrada_sig',$this->fecha_entrada_sig,true);
		$criteria->compare('fecha_salida_sig',$this->fecha_salida_sig,true);
		$criteria->compare('codigo_nomina_real',$this->codigo_nomina_real);
		$criteria->compare('cod_organismo_adscrito',$this->cod_organismo_adscrito,true);
		$criteria->compare('lunes_primera',$this->lunes_primera);
		$criteria->compare('lunes_segunda',$this->lunes_segunda);
		$criteria->compare('lunes_retroactivo',$this->lunes_retroactivo);
		$criteria->compare('hay_retroactivo',$this->hay_retroactivo,true);
		$criteria->compare('dias_trabajados',$this->dias_trabajados);
		$criteria->compare('mes_entrada',$this->mes_entrada);
		$criteria->compare('dia_entrada',$this->dia_entrada);
		$criteria->compare('anio_entrada',$this->anio_entrada);
		$criteria->compare('mes_salida',$this->mes_salida);
		$criteria->compare('dia_salida',$this->dia_salida);
		$criteria->compare('anio_salida',$this->anio_salida);
		$criteria->compare('horas_semanales',$this->horas_semanales);
		$criteria->compare('fecha_ingreso_cargo',$this->fecha_ingreso_cargo,true);
		$criteria->compare('mes_ingreso_cargo',$this->mes_ingreso_cargo);
		$criteria->compare('dia_ingreso_cargo',$this->dia_ingreso_cargo);
		$criteria->compare('anio_ingreso_cargo',$this->anio_ingreso_cargo);
		$criteria->compare('fecha_fe_vida',$this->fecha_fe_vida,true);
		$criteria->compare('fecha_encargaduria',$this->fecha_encargaduria,true);
		$criteria->compare('fecha_comision_servicio',$this->fecha_comision_servicio,true);
		$criteria->compare('organismo_comision_servicio',$this->organismo_comision_servicio,true);
		$criteria->compare('fecha_tipo_personal',$this->fecha_tipo_personal,true);
		$criteria->compare('fecha_ultimo_movimiento',$this->fecha_ultimo_movimiento,true);
		$criteria->compare('codigo_patronal',$this->codigo_patronal,true);
		$criteria->compare('jubilacion_planificada',$this->jubilacion_planificada,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * @return CDbConnection the database connection used for this class
	 */
	public function getDbConnection()
	{
		return Yii::app()->db2;
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Trabajador the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
