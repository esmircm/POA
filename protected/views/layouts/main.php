<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>SIMAP</title>

        <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/fonts/css/font-awesome.min.css" media="screen, projection">

        <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/custom.css" media="screen, projection">




    </head>


    <body class="nav-md">

        <section id="container">



            <div class="container body">


                <div class="main_container">

                    <div class="col-md-3 left_col">
                        <div class="left_col scroll-view">

                            <div class="navbar nav_title" style="border: 0;">
                                <a class="site_title"><i class="fa fa-group"></i> <span>SIMAP</span></a>
                            </div>
                            <div class="clearfix"></div>

                            <!-- menu prile quick info -->
                            <div class="profile">
                                <div class="profile_pic">
                                    <img src="<?php echo Yii:: app()->baseUrl . '/images/banavih_ndice1.png' ?> " width="100" height="65" >
                                </div>
                                <div class="profile_info">
                                    <span>Bienvenid@,</span>
                                    <h2><?php echo Yii::app()->user->name; ?></h2>
                                </div>
                            </div>
                            <!-- /menu prile quick info -->

                            <br />

                            <!-- sidebar menu -->
                            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">

                                <div class="menu_section">
                                    <h3>General</h3>
                                    <ul class="nav side-menu">
                                        
                                        <li><a><i class="fa fa-home"></i> Simap <span class="fa fa-chevron-down"></span></a>
                                            <ul class="nav child_menu" style="display: none">
                                                <li><a href="<?php echo $this->createUrl('/proyecto/index'); ?>">
                                                        <i class="fa fa-pencil"></i>
                                                        <span>Registrar Proyecto</span>
                                                    </a>
                                                </li>

                                            </ul>
                                        </li>


                                        <li><a href="<?php echo $this->createUrl('/graficas/graficarecepcion'); ?>">
                                                <i class="fa fa-pie-chart"></i>
                                                <span>Gráficas</span>
                                            </a>
                                        </li>
                                        <li><a><i class="fa fa-file-pdf-o"></i> Reportes <span class="fa fa-chevron-down"></span></a>
                                            <ul class="nav child_menu" style="display: none">
                                                <li><a href="<?php echo $this->createUrl('/vswReporteFinal/reporte'); ?>">
                                                        <i class="fa fa-check"></i>
                                                        <span>Reporte Final</span>
                                                    </a>
                                                </li>

                                            
                                           
                                                <li><a href="<?php echo $this->createUrl('/evaluacion/Reporte_Rechazados'); ?>">
                                                        <i class="fa fa-times"></i>
                                                        <span>Rechazados</span>
                                                    </a>
                                                </li>

                                            </ul>
                                        </li>

                                    </ul>
                                </div>

                            </div>
                            <!-- /sidebar menu -->

                            <!-- /menu footer buttons -->



                            <div class="sidebar-footer hidden-small">

                                <?php if (Yii::app()->user->checkAccess('admin')) { ?>

                                    <center><div><h5>Administrador</h5></div></center>

                                    <?php if (Yii::app()->user->checkAccess('action_ui_usermanagementadmin')) { ?>

                                        <a data-toggle="tooltip" data-placement="top" title="Gestión de Usuarios" href="<?php echo $this->createUrl('/cruge/ui/usermanagementadmin'); ?>">

                                        <?php } ?>
                                        <i class="glyphicon glyphicon-user"></i>

                                    </a>


                                    <a data-toggle="tooltip" data-placement="top" title="Campos Personalizados" href="<?php echo $this->createUrl('/cruge/ui/fieldsadminlist'); ?>">
                                        <i class="glyphicon glyphicon-tasks"></i>

                                    </a>



                                    <a data-toggle="tooltip" data-placement="top" title="Roles y Asignaciones" href="<?php echo $this->createUrl('/cruge/ui/rbaclistroles'); ?>">
                                        <i class="glyphicon glyphicon-check"></i>

                                    </a>

                                    <a data-toggle="tooltip" data-placement="top" title="Sistema" href="<?php echo $this->createUrl('/cruge/ui/sessionadmin'); ?>">
                                        <i class="glyphicon glyphicon-wrench"></i>

                                    </a>
                                <?php } ?>

                                <a aling="right" class="glyphicon glyphicon-off" href="<?php echo $this->createUrl('/site/logout'); ?>"></a>


                            </div>
                            <!-- /menu footer buttons -->
                        </div>
                    </div>

                    <!-- top navigation -->
                    <div class="top_nav">

                        <div class="nav_menu">
                            <nav class="" role="navigation">
                                <div class="nav toggle">
                                    <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                                </div>

                                <ul class="nav navbar-nav navbar-right">
                                    <li class="">
                                        <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                            <span class="glyphicon glyphicon-user"><?php echo Yii::app()->user->name; ?></span>
                                            <span class=" fa fa-angle-down"></span>
                                        </a>
                                        <ul class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">

                                            <?php if (Yii::app()->user->isGuest) { ?><li><a class="glyphicon glyphicon-lock" href="<?php echo $this->createUrl('/cruge/ui/login'); ?>"><i class="fa fa-key"></i>Ingresar</a></li><?php } ?>
                                            <?php if (!Yii::app()->user->isGuest) { ?><li><a class="" href="<?php echo $this->createUrl('/cruge/ui/usermanagementupdate', array('id' => Yii::app()->user->id)); ?>"><i class="fa fa-key"></i>Cambiar Clave</a></li><?php } ?>
                                            <?php if (!Yii::app()->user->isGuest) { ?><li><a class="fa fa-sign-out pull-right" href="<?php echo $this->createUrl('/site/logout'); ?>"><i class=""></i>Salir</a></li><?php } ?>
                                        </ul>
                                    </li>

                                    <li role="presentation" class="dropdown">

                                        <!--##NOTIFICACIONES##-->
                                        <!--                                        <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                                                                                    <i class="fa fa-envelope-o"></i>
                                                                                    <span class="badge bg-green">6</span>
                                                                                </a>-->
                                        <ul id="menu1" class="dropdown-menu list-unstyled msg_list animated fadeInDown" role="menu">
                                            <li>
                                                <a>
                                                    <span class="image">
                                                        <img src="images/img.jpg" alt="Profile Image" />
                                                    </span>
                                                    <span>
                                                        <span>John Smith</span>
                                                        <span class="time">3 mins ago</span>
                                                    </span>
                                                    <span class="message">
                                                        Film festivals used to be do-or-die moments for movie makers. They were where... 
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a>
                                                    <span class="image">
                                                        <img src="images/img.jpg" alt="Profile Image" />
                                                    </span>
                                                    <span>
                                                        <span>John Smith</span>
                                                        <span class="time">3 mins ago</span>
                                                    </span>
                                                    <span class="message">
                                                        Film festivals used to be do-or-die moments for movie makers. They were where... 
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a>
                                                    <span class="image">
                                                        <img src="images/img.jpg" alt="Profile Image" />
                                                    </span>
                                                    <span>
                                                        <span>John Smith</span>
                                                        <span class="time">3 mins ago</span>
                                                    </span>
                                                    <span class="message">
                                                        Film festivals used to be do-or-die moments for movie makers. They were where... 
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a>
                                                    <span class="image">
                                                        <img src="images/img.jpg" alt="Profile Image" />
                                                    </span>
                                                    <span>
                                                        <span>John Smith</span>
                                                        <span class="time">3 mins ago</span>
                                                    </span>
                                                    <span class="message">
                                                        Film festivals used to be do-or-die moments for movie makers. They were where... 
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <div class="text-center">
                                                    <a>
                                                        <strong><a href="inbox.html">See All Alerts</strong>
                                                        <i class="fa fa-angle-right"></i>
                                                    </a>
                                                </div>
                                            </li>
                                        </ul>
                                    </li>

                                </ul>
                            </nav>
                        </div>

                    </div>
                    <!-- /top navigation -->


                    <!-- page content -->
                    <div class="right_col" role="main">

                        <section id="main-content">
                            <section class="wrapper" style='margin-top: 8%;'>
                                <!--mini statistics start-->
                                <?php echo $content; ?>
                                <!--mini statistics end-->
                            </section>
                        </section>

                        <div id="expirado"></div>
                        <!-- /footer content -->
                    </div>
                    <!-- /page content -->

                </div>

            </div>
        </section>

        <div id="custom_notifications" class="custom-notifications dsp_none">
            <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
            </ul>
            <div class="clearfix"></div>
            <div id="notif-group" class="tabbed_notifications"></div>
        </div>
        <script src="<?php echo Yii::app()->baseUrl; ?>/js/nicescroll/jquery.nicescroll.min.js"></script>
        <script src="<?php echo Yii::app()->baseUrl; ?>/js/custom.js"></script>
    </body>

</html>

<?php
//$url_redirect = CHtml::normalizeUrl(array('/site/index'));
$url_redirect = CHtml::normalizeUrl(array('/cruge/ui/login'));
$url_valida_sesion = CHtml::normalizeUrl(array('/cruge/ui/login'));
$url_destroy_session = CHtml::normalizeUrl(array('/site/logout'));
/* Yii::app()->getClientScript()->registerScript("core_cruge", "
  var tstampActual = 0;
  var comprobar = 1200000;



  function kill_session() {
  if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }else{// code for IE6, IE5
  xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
  }
  xmlhttp.open('GET','$url_destroy_session',false);
  xmlhttp.send();

  document.getElementById('expirado').innerHTML=xmlhttp.responseText;
  document.location.href = '$url_redirect';

  }

  function actividad() {

  var tstamp = new Date().getTime();

  if (Math.abs(tstampActual - tstamp) > comprobar) {
  kill_session();
  }
  }

  $( document ).ready(function() {
  // Handler for .ready() called.
  document.body.addEventListener('mousemove', function() {
  tstampActual = new Date().getTime();
  }, false);
  setInterval(function() {actividad()}, comprobar);
  });
  ", CClientScript::POS_LOAD); */
?>


