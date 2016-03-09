<?php
/* @var $this SiteController */

$this->pageTitle = Yii::app()->name;
?>
<div class="container-fluid" style="background-color: #47abff ">

    <?php
    $this->widget('booster.widgets.TbCarousel', array(
        'items' => array(
            array(
                'image' => Yii::app()->baseUrl . '/img/bg-logo2.png', 'imageOptions' => array('style' => 'display: block; margin: 10px auto;'),
            ),
            array(
                'image' => Yii::app()->baseUrl . '/img/bg-logo.png', 'imageOptions' => array('style' => 'display: block; margin: 10px auto;'),
            ),
//            array(
//                'image' => Yii::app()->baseUrl . '/img/bg-logo2.png', 'imageOptions' => array('style' => 'display: block; margin: 10px auto;'),
//            ),
        ),
        'htmlOptions' => array('class' => 'slide'),
    ));
    ?>
</div>