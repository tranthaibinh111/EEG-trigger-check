### Parallel Port Trigger for eyelink

We tested the complete delay of sending a parallelport trigger over an eyelink system.
We conntected a parallelport cable from our stimulation pc to the eyelink-host. We set the eyelink-host parallelport to a random integer using: 
```sendCommand("!*write_ioport 0x378 %i"%(randint))```

We tested the *pylink* package from sr-research directly and the pygaze wrapper.
In both cases, for 2000 tested triggers, we observed the majority below 1ms.

In pygaze <0.1% of triggers have a high delay (>10ms). It is unclear where those come from as pygaze is a simple wrapper of pylink.

Pylink:
![pylink trigger test](./figures/pylinkhist.png)

PyGaze:
![PyGaze trigger test](./figures/pygazehist.png)


[The script can be found here](./code/pylink_triggertest.py)