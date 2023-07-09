# StatefulArch

StatetefulArch contains a set of useful entities to develop scalable iOS applications using either SwiftUI or UIKit along with Combine.

## Architecture Overview

This architecture proposes to split screens into independent modules which of them consists of three main entities - View, Interceptor and State.

![architecture diagram](Docs/Images/ArchitectureDiagram.png)

### View

View is responsible for user interface and it doesn't contain any business logic or input data validations. Also it delegates user actions processing to Interceptor.

### Interceptor

Interceptor processes user actions received from View and updates State. Interceptor may contain input data validations but it's not responsible for business logic directly. 

> There is another entity in this architecture called Scenario which is responsible for business logic. Scenario isn't displayed on the diagram due to business logic optionality - some screens may not contain business logic such as screens which contain only static content.

### State

This entity keeps screen's state and determines View's behavior.
