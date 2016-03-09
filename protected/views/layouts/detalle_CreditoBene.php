<?php /* @var $this Controller */ ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>

        <script src="<?php echo Yii::app()->baseUrl; ?>/js/pace.js"></script>
        <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/carga.css" />


        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="language" content="en" />

        <!-- blueprint CSS framework -->
        <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/screen.css" media="screen, projection" />
        <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/js/jquery-ui/jquery-ui-1.10.1.custom.min.css" />
        <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/js/administrador/css3clock/css/style.css" />
        <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/print.css" media="print" />
        <link rel="shortcut icon" href="<?php echo Yii::app()->baseUrl; ?>/images/favicon.png" />
        <!--[if lt IE 8]>
        <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/ie.css" media="screen, projection" />
        <![endif]-->

        <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/main.css" />
        <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/form.css" />
        <link rel="stylesheet" type="text/css" href="<?php echo Yii::app()->request->baseUrl; ?>/css/menu.css" />

        <title>Estatus 0800MIHOGAR</title>
        <?php $totales = Generico::cantCasos(NULL, 66, NULL); ?>
    </head>
    <body>
        <section id="container">
            <header class="header fixed-top clearfix">
                <div class="brand" align="center" style="height: 60%;">


                    <div class="sidebar-toggle-box">
                        <div class="fa fa-bars glyphicon glyphicon-list"></div>
                    </div>

                    <br><div align="center"><img src="<?php echo Yii:: app()->baseUrl . '/img/work.png' ?> " width="120" height="100"></div><br>
                            </div>

                            <div class="nav notify-row" id="top_menu">
                                <!--  notification start -->
                                <!--                    <ul class="nav top-menu">
                                                         settings start
                                                        <li class="dropdown">
                                                            <a data-toggle="dropdown" class="dropdown-toggle" href="<?php echo $this->createUrl('site/index'); ?>">
                                                                <span class="glyphicon glyphicon-stats" aria-hidden="true"></span>
                                                            </a>
                                                        </li>
                                                         notification dropdown end
                                                    </ul>-->
                                <!--  notification end -->
                            </div>
                            <div class="top-nav clearfix">
                                <!--search & user info start-->
                                <ul class="nav pull-right top-menu">
                                    <!-- user login dropdown start-->
                                    <li class="dropdown">
                                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                            <span class="glyphicon glyphicon-user"><?php echo Yii::app()->user->name; ?></span>
                                            <b class="caret"></b>
                                        </a>
                                        <ul class="dropdown-menu extended logout">
                                            <?php if (Yii::app()->user->isGuest) { ?><li><a class="glyphicon glyphicon-lock" href="<?php echo $this->createUrl('/cruge/ui/login'); ?>"><i class="fa fa-key"></i>Ingresar</a></li><?php } ?>
                                            <?php if (!Yii::app()->user->isGuest) { ?><li><a class="glyphicon glyphicon-lock" href="<?php echo $this->createUrl('/cruge/ui/usermanagementupdate', array('id' => Yii::app()->user->id)); ?>"><i class="fa fa-key"></i>Cambiar Clave</a></li><?php } ?>
                                            <?php if (!Yii::app()->user->isGuest) { ?><li><a class="glyphicon glyphicon-off" href="<?php echo $this->createUrl('/site/logout'); ?>"><i class="fa fa-key"></i>Salir</a></li><?php } ?>
                                        </ul>
                                    </li>
                                    <?php if (!Yii::app()->user->isGuest) { ?><li>
                                            <a href="#">
                                                <i class="fa fa-envelope"></i> <span>Casos Pendientes</span>
                                                <small class="label pull-right bg-red"><?php echo $totales['total']; ?></small>

                                            </a>
                                        </li><?php } ?>
                                    <!-- user login dropdown end -->
                                </ul>
                                <!--search & user info end-->
                            </div>
                            </header>
                            <aside>
                                <div id="sidebar" class="nav-collapse">
                                    <div class="leftside-navigation" style ="margin-top: 19%;">
                                        <ul class="sidebar-menu" id="nav-accordion">
                                            <li>
                                                <a href="<?php echo $this->createUrl('/site/indexAdmin'); ?>">
                                                    <i class="glyphicon glyphicon-home"></i>
                                                    <span>Inicio</span>
                                                </a>


                                            </li>
                                        </ul>
                                        <!-- sidebar menu end-->
                                    </div>
                                </div>
                            </aside>
                            <section id="main-content">
                                <section class="wrapper" style='margin-top: 8%;'>
                                    <!--mini statistics start-->
                                    <?php echo $content; ?>
                                    <!--mini statistics end-->
                                </section>
                            </section>

                            <div id="expirado"></div>

                            </section>

                            </body>

                            <script src="<?php echo Yii::app()->baseUrl; ?>/js/administrador/jquery.dcjqaccordion.2.7.js"></script>
                            <script src="<?php echo Yii::app()->baseUrl; ?>/js/administrador/jquery.scrollTo.min.js"></script>
                            <script src="<?php echo Yii::app()->baseUrl; ?>/js/jQuery-slimScroll-1.3.0/jquery.slimscroll.js"></script>
                            <script src="<?php echo Yii::app()->baseUrl; ?>/js/administrador/jquery.nicescroll.js"></script>
                            <script src="<?php echo Yii::app()->baseUrl; ?>/js/administrador/skycons/skycons.js"></script>
                            <script src="<?php echo Yii::app()->baseUrl; ?>/js/jquery.scrollTo/jquery.scrollTo.js"></script>
                            <script src="<?php echo Yii::app()->baseUrl; ?>/js/administrador/gauge/gauge.js"></script>
                            <script src="<?php echo Yii::app()->baseUrl; ?>/js/administrador/css3clock/js/css3clock.js"></script>
                            <script src="<?php echo Yii::app()->baseUrl; ?>/js/administrador/scripts.js"></script>
                            </html>