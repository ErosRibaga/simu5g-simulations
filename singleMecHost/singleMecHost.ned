//
//                           Simu5G
//
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself,
// and cannot be removed from it.
//

package miesimulazioni.simulations.singleMecHost;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.Eth10G;
import simu5g.world.radio.LteChannelControl;
import simu5g.common.binder.Binder;
import simu5g.common.carrierAggregation.CarrierAggregation;
import simu5g.nodes.Upf;
import simu5g.nodes.NR.gNodeB;
import simu5g.nodes.NR.NRUe;
import simu5g.nodes.mec.MECHost;

import simu5g.nodes.mec.MECOrchestrator.MecOrchestrator;
import simu5g.nodes.mec.UALCMP.UALCMP;



network singleMecHost
{
    parameters:

        int numCars = default(0);

        double playgroundSizeX @unit(m); // x size of the area the nodes are in (in meters)
        double playgroundSizeY @unit(m); // y size of the area the nodes are in (in meters)
        double playgroundSizeZ @unit(m); // z size of the area the nodes are in (in meters)
        @display("bgb=805.92,499.56");

    submodules:

        routingRecorder: RoutingTableRecorder {
            @display("p=720.01,122.36125;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=720.01,184.0475");
        }
        channelControl: LteChannelControl {
            @display("p=718.9988,68.765;is=s");
        }
        binder: Binder {
            @display("p=720.01,251.80125;is=s");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=720.01,314.49875;is=s");
        }
        upf: Upf {
            @display("p=384.275,249.77875;is=l");
        }
        gNodeB1: gNodeB {
            @display("p=140,250;is=vl");
        }
        car[numCars]: NRUe {
            @display("p=300,300");
        }
        //# MEC module
        mecHost: MECHost {
            @display("p=384.275,140.56375;is=l");
        }

        mecOrchestrator: MecOrchestrator {
            @display("p=579.4462,249.77875;is=l");
        }

        ualcmp: UALCMP {
            @display("p=480.34375,248.7675;i=device/smallrouter");
        }


    connections allowunconnected:

        upf.pppg++ <--> Eth10G <--> gNodeB1.ppp;
        ualcmp.ppp++ <--> Eth10G <--> upf.filterGate;

        ualcmp.toMecOrchestrator --> mecOrchestrator.fromUALCMP;
        ualcmp.fromMecOrchestrator <-- mecOrchestrator.toUALCMP;

        //#	mec
        // direct connection between gNodeB1 and mecHost
        mecHost.pppENB++ <--> Eth10G <--> gNodeB1.pppMEHost;
}
