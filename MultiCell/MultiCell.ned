package miesimulazioni.simulations.MultiCell;



import inet.node.ethernet.Eth10G;
import simu5g.nodes.PgwStandard;
import simu5g.nodes.Upf;
import simu5g.nodes.eNodeB;
import simu5g.nodes.Ue;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import simu5g.world.radio.LteChannelControl;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import simu5g.common.binder.Binder;
import simu5g.common.carrierAggregation.CarrierAggregation;



//
// TODO documentation
//
network MultiCell
{
    submodules:
        channelControl: LteChannelControl {
            @display("p=87.0625,69.65;is=s");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=88.30625,125.61875;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=88.30625,182.83125;is=s");
        }
        binder: Binder {
            @display("p=88.30625,249.99374;is=s");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=88.30625,305.9625;is=s");
        }
        server: StandardHost {
            @display("p=212,118;is=n;i=device/server");
        }
        router: Router {
            @display("p=330.645,115.9725;i=device/smallrouter");
        }
        pgw: PgwStandard {
            @display("p=446.6175,117.20625");
        }
        eNB1: eNodeB {
            @display("p=319,305;is=l");
        }
        eNB2: eNodeB {
            @display("p=549,305;is=l");
        }
        ue11: Ue {
            @display("p=263,416");
        }
        ue12: Ue {
            @display("p=347,425");
        }
        ue21: Ue {
            @display("p=510,416");
        }
        ue22: Ue {
            @display("p=588,425");
        }


    connections:
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> pgw.filterGate;
        pgw.pppg++ <--> Eth10G <--> eNB1.ppp;
        pgw.pppg++ <--> Eth10G <--> eNB2.ppp;

        //# X2 connections
        eNB1.x2++ <--> Eth10G <--> eNB2.x2++;
}
