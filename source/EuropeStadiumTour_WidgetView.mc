import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
using Toybox.Time;
using Toybox.Time.Gregorian;

var fontResources = {
    208 => Rez.Fonts.Font208,
    218 => Rez.Fonts.Font218,        
    240 => Rez.Fonts.Font240,
    260 => Rez.Fonts.Font260,
    280 => Rez.Fonts.Font280,
    360 => Rez.Fonts.Font360,
    390 => Rez.Fonts.Font390,
    416 => Rez.Fonts.Font416,
    454 => Rez.Fonts.Font454
};

var logoResources = {
    208 => Rez.Drawables.Logo208,
    218 => Rez.Drawables.Logo218,        
    240 => Rez.Drawables.Logo240,
    260 => Rez.Drawables.Logo260,
    280 => Rez.Drawables.Logo280,
    360 => Rez.Drawables.Logo360,
    390 => Rez.Drawables.Logo390,
    416 => Rez.Drawables.Logo416,
    454 => Rez.Drawables.Logo454
};

var concertEpochs = [
    1715389200,
    1715475600,
    1715734800,
    1715821200,
    1715994000,
    1716080400,
    1716512400,
    1717030800,
    1717549200,
    1717808400,
    1718067600,
    1718413200,
    1718672400,
    1718758800,
    1719104400,
    1719450000,
    1719536400,
    1720141200,
    1720659600,
    1720746000,
    1721178000,
    1721264400,
    1721523600,
    1721955600,
    1722042000,
    1722214800,
    1722301200,
    1722387600
];

var concertPlaces = [
    "PRAGUE",
    "PRAGUE",
    "DRESDEN",
    "DRESDEN",
    "DRESDEN",
    "DRESDEN",
    "BELGRADE",
    "ATHENS",
    "SAN\nSEBASTIAN",
    "MARSEILLE",
    "BARCELONA",
    "LYON",
    "NIJMEGEN",
    "NIJMEGEN",
    "DUBLIN",
    "OSTEND",
    "OSTEND",
    "COPENHAGEN",
    "FRANKFURT",
    "FRANKFURT",
    "KLAGENFURT",
    "KLAGENFURT",
    "REGGIO\nEMILIA",
    "GELSEN\nKIRCHEN",
    "GELSEN\nKIRCHEN",
    "GELSEN\nKIRCHEN",
    "GELSEN\nKIRCHEN",
    "GELSEN\nKIRCHEN"
];

var width;
var height;
var logo;
var font;
var concertEpoch;
var concertPlace;
var settingsChanged;

class EuropeStadiumTour_WidgetView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        width = dc.getWidth();
        height = dc.getHeight();
    }

    function onShow() as Void {
        loadResources();
        settingsChanged = false;
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        if (settingsChanged) {
            settingsChanged = false;
            loadResources();
        }
        dc.drawBitmap((width / 2) - (logo.getWidth() / 2), logo.getHeight() / 9, logo);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        var now = Time.now().value();
        var daysBetween = (concertEpoch - now) / 60 / 60 / 24 + 1;
        var daysString;
        if (daysBetween > 0) {
            daysString = daysBetween.format("%d") + " Days";
        } else {
            daysString = "--";
        }

        dc.drawText(
            width / 2,
            height * 0.67,
            font,
            concertPlace,
            Graphics.TEXT_JUSTIFY_CENTER
        );
        dc.drawText(
            width / 2,
            height * 0.85,
            Graphics.FONT_SMALL,
            daysString,
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }

    function onHide() as Void {
    }

    function loadResources() as Void {
        font = Toybox.WatchUi.loadResource(fontResources.get(height));
        logo = Toybox.WatchUi.loadResource(logoResources.get(height));

        var concert = Application.Properties.getValue("Concert") as Number;
        concertPlace = concertPlaces[concert];
        concertEpoch = concertEpochs[concert];
    }
}
