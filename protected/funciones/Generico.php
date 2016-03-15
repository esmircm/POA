<?php

class Generico {
    /*
     * FUNCION QUE PERMITE DAR FORMATO A LA FECHA QUE VIENE DE DATEPICKER
     */

    public function formatoFecha($fechaIn) {
        $fecha = $fechaIn; //FECHA SIN FORMATO
        $fechaRemplazando = str_replace('/', '-', $fecha);
        $fechaFormato = explode('-', $fechaRemplazando);
        $dia = $fechaFormato[0];
        $mes = $fechaFormato[1];
        $año = $fechaFormato[2];

        $fechaFormato = date('Y-m-d', strtotime($año . "-" . $mes . "-" . $dia)); //DANDO FORMATO A LA FECHA DE LA CITA

        return $fechaFormato;
    }

    /**
     * @author MinMujer
     * @tutorial Esta funcion permite redireccionar a la vista principa despues del guardado
     * @param integer $id_personal
     * @param integer $id_usuario
     */
    public function renderTraza() {
       
        $cedula = Yii::app()->getSession()->get('CedulaUser');
        $IdPersonal = Personal::model()->findByAttributes(array('cedula' => $cedula))->id_personal;
        //verifico que las sessiones estén llenas
        if ($IdPersonal == '') {
            throw new CHttpException(400, 'Solicitud invalida, Por favor no repita esta solicitud nuevamente.');
        } else {
            //consulto en la base de datos para saber en que pantalla está.
            $traza = Traza::VerificarTraza($IdPersonal, Yii::app()->user->id);
        }

        //evalúo la session traza para saber a que pantalla debo redirigir.
        switch ($traza) {
            case 1:// TERMINO LA ACTUALIZACION DE LA VISTA PERSONAL
                $this->redirect(array('educacion/create'));
                break;
            case 2: // TERMINO LA ACTUALIZACIOND DE LA VISTA EDUCACION
                $this->redirect(array('familiar/create'));
                break;
            case 4: // INDICA QUE YA CULMINO LA ACTUALIZACION
                $this->redirect(array('/site/registrofinal'));
                break;
            case 0: // INICA QUE NO HA INICIADO LA ACTUALIZACION
                $this->redirect(array('personal/create'));
                break;
        }
    }

    
}
?>