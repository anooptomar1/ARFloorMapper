This project aims at creating an app that allows the user to create a floor / room layout of their appartment or house by using an ARKit-enabled iOS device and simply walking through the rooms.

The rough layout of the initial approach is to use the planes from the plane detection from ARKit to construct a growing polygon (or set of polygons) that resemble(s) the floor layout. That is, in its initial state a floor is the first detected plane. For every further detected plane it must be checked, if that plane has the same height and orientation (in space) as the initial plane. If so, it is added to that floor. If not, the plane might belong to another floor.

The project is still in a very early phase and not producing any usable results yet, therefore any help is appreciated.
