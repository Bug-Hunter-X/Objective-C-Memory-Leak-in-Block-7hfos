# Objective-C Memory Leak in Block

This repository demonstrates a common memory leak in Objective-C that can occur when creating strong references to objects within blocks. The leak happens because the object retains the newly created strong reference which is not released and keeps the object in memory.