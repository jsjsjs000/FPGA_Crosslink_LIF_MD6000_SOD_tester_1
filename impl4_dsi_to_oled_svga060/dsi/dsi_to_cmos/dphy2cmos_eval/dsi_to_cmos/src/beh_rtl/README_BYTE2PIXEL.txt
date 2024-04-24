Generated behavioral/obfuscated model for byte2pixel needs to be modified to avoid race conditions during simulation. 

Details:
Obfuscation script inserts scrambler that uses non-blocking statements inside a combinational block. To avoid race conditions, the non-blocking sign needs to be replaced with blocking sign.
