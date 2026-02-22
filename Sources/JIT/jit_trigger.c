#include <stdio.h>
extern void pthread_set_self_restrict_it_is_single_threaded_np(void);
void trigger_jit_bridge() {
    printf("Titan: JIT Spark Ignited\n");
    pthread_set_self_restrict_it_is_single_threaded_np();
}
