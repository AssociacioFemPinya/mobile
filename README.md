# fempinya3_flutter_app

A new Flutter project.

## TO DOCUMENT SOMEWHERE

### Nullables in bloc states
Do not set properties in the bloc state as null after initialization. The reason is that, when calling copyWith(), if it's not specifically passed, the value will be null. Hence you don't know if the value is null because the intention is to change some other property, or because we want to set it to null.

To avoid this situation, you can have a boolean next to the value to enable/disable the functionality. For example a filter dayFilter has dayFilterEnabled next to it.

