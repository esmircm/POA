<?php

/**
 * This is the model class for table "actualizar.traza".
 *
 * The followings are the available columns in table 'actualizar.traza':
 * @property integer $id_traza
 * @property integer $id_personal
 * @property integer $n_traza
 * @property integer $id_usuario
 * @property string $fecha_traza
 */
class Traza extends CActiveRecord {

    /**
     * @return string the associated database table name
     */
    public function tableName() {
        return 'actualizar.traza';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules() {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('fecha_traza', 'required'),
            array('id_personal, n_traza, id_usuario', 'numerical', 'integerOnly' => true),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('id_traza, id_personal, n_traza, id_usuario, fecha_traza', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations() {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
                //'IdPersonal' => array(self::HAS_ONE, 'Personal', 'id_personal'),
        );
    }

    /**
     * VERIFICAR TRAZA POR ID_PERSONAL, ID_USUARIO
     * @param integer $id_personal
     * @param integer $id_usuario
     * @return integer
     */
    public function VerificarTraza($id_personal, $id_usuario) {
        $traza = Traza::model()->findByAttributes(array('id_personal' => $id_personal, 'id_usuario' => $id_usuario));
        if (!empty($traza)) {
            return $traza->n_traza;
        } else {
            $historico = Historico::model()->findByAttributes(array('id_personal' => $id_personal, 'id_usuario' => $id_usuario));
            if (empty($historico)) {
                return 0; // INDICA QUE NO SE A INICIADO LA ACTUALIZACION
            } else {
                return 4; // INDICA QUE SE TERMINO LA ACTUALIZACION
            }
        }
    }
    /**
     * ACTUALIZAR E INSERT TRAZA
     * @param integer $id_personal
     * @param integer $id_usuario 
     * @return integer 
     */
    public function ObtenerIdTraza($id_personal, $id_usuario) {
        $data = Traza::model()->findByAttributes(array('id_personal' => $id_personal, 'id_usuario' => $id_usuario)); //BUSQUEDA EN LA TABLA TRAZA

        if ($data) {//si consigo un registro en trazaRegistro envio el valor para que redireccione la pantalla
            return $data->id_traza;
        } else {

            return false;
        }
    }

    /**
     * FUNCION QUE PERMITE ACTUALIZAR E INSERTAR EN LA TABLA TRAZA
     * @param integer $id_personal
     * @param integer $id_usuario 
     * @param integer $nu_traza numero de la traza
     * @param integer $case=1 inserta en la tabla traza // $case=2 actualizar en la traza
     * @return integer
     */
    public function actionInsertUpdateTraza($case, $id_personal, $id_usuario, $nu_traza, $idTraza = NULL) {
        switch ($case) {
            case 1:
                $traza = new Traza;
                $traza->id_personal = $id_personal;
                $traza->id_usuario = $id_usuario;
                $traza->n_traza = $nu_traza;
                $traza->fecha_traza = 'now()';

                if ($traza->save()) {
                    return true;
                } else {
                    return false;
                }
                break;
            case 2:
                $traza = Traza::model()->findByPk($idTraza);
                $traza->n_traza = $nu_traza;
                $traza->fecha_traza = 'now()';
                if ($traza->save()) {
                    return true;
                } else {
                    return false;
                }

                break;
        }
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels() {
        return array(
            'id_traza' => 'Id Traza',
            'id_personal' => 'Id Personal',
            'n_traza' => 'N Traza',
            'id_usuario' => 'Id Usuario',
            'fecha_traza' => 'Fecha Traza',
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

        $criteria->compare('id_traza', $this->id_traza);
        $criteria->compare('id_personal', $this->id_personal);
        $criteria->compare('n_traza', $this->n_traza);
        $criteria->compare('id_usuario', $this->id_usuario);
        $criteria->compare('fecha_traza', $this->fecha_traza, true);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    /**
     * Returns the static model of the specified AR class.
     * Please note that you should have this exact method in all your CActiveRecord descendants!
     * @param string $className active record class name.
     * @return Traza the static model class
     */
    public static function model($className = __CLASS__) {
        return parent::model($className);
    }

    public function getTraza($traza) {
        if ($traza == 0) {
            return array('porcentaje'=>'0%', 'valor'=>'0');
        } elseif ($traza == 1) {
            return array('porcentaje'=>'30%', 'valor'=>'30');
        } elseif ($traza == 2) {
            return array('porcentaje'=>'60%', 'valor'=>'60');
        } elseif ($traza == 3) {
            return array('porcentaje'=>'100%', 'valor'=>'100');
        }
    }

}
