#include <stdio.h>
#include <pthread.h>

void trigger_jit_bridge() {
    printf("Titan: JIT Spark Ignited for A18 Pro\n");
    pthread_set_self_restrict_it_is_single_threaded_np();
}
