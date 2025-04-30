# tutrc_ament

`ament_cmake_auto` に基づき、`include/` は自動でインクルードディレクトリとして認識される

`tutrc_ament_final` を使用すると、`config/`, `launch/`, `rviz/` は自動で `share/` 以下にインストールされる

## 仕様

### tutrc_ament_init

引数なし

### tutrc_ament_final

引数なし

### tutrc_ament_add_executable

- その他の引数:
  - 指定した場合: `ament_auto_add_executable` に引き継がれる
  - 指定しなかった場合: `src/` 以下のソースファイルが実行ファイルとしてビルドされる

### tutrc_ament_add_library

- その他の引数:
  - 指定した場合: `ament_auto_add_library` に引き継がれる
  - 指定しなかった場合: `src/` 以下のソースファイルが共有ライブラリとしてビルドされる

### tutrc_ament_register_node

- PLUGIN: `名前空間::クラス名` を指定
- EXECUTABLE: 実行ファイル名を指定
- HEADER: PLUGINで指定したクラスの定義が存在するヘッダファイルへのパスを指定
  - `include/${PROJECT_NAME}/${PROJECT_NAME}_component.hpp` に存在する場合省略可
- その他の引数: 
  - 指定した場合: `tutrc_ament_add_library` に引き継がれる
  - 指定しなかった場合: `src/` 以下のソースファイルが共有ライブラリとしてビルドされる

### tutrc_ament_generate_interfaces
- その他の引数: 
  - 指定した場合: `rosidl_generate_interfaces` に引き継がれる
  - 指定しなかった場合: `msg/*.msg` と `srv/*.srv` をもとにカスタムメッセージが生成される。新規ファイルを追加した場合、キャッシュを消す必要がある。

引数なし

## 使用例

### 共有ライブラリを作成する

```xml
<buildtool_depend>tutrc_ament</buildtool_depend>
```

```cmake
cmake_minimum_required(VERSION 3.8)
project(example_shared_library)

find_package(tutrc_ament REQUIRED)

tutrc_ament_init()

tutrc_ament_add_library(${PROJECT_NAME})

tutrc_ament_final()
```

### Header-onlyライブラリを作成する

```xml
<buildtool_depend>tutrc_ament</buildtool_depend>
```

```cmake
cmake_minimum_required(VERSION 3.8)
project(example_interface_library)

find_package(tutrc_ament REQUIRED)

tutrc_ament_init()

tutrc_ament_add_library(${PROJECT_NAME} INTERFACE)

tutrc_ament_final()
```

### ROS 2 Nodeを作成する

```xml
<buildtool_depend>tutrc_ament</buildtool_depend>
<depend>rclcpp_components</depend>
```

```cmake
cmake_minimum_required(VERSION 3.8)
project(example_node)

find_package(tutrc_ament REQUIRED)

tutrc_ament_init()

tutrc_ament_register_node(${PROJECT_NAME}_component
  PLUGIN      "example_node::ExampleNode"
  EXECUTABLE  "example_node"
)

tutrc_ament_final()
```

### カスタムメッセージを作成する

```xml
<buildtool_depend>tutrc_ament</buildtool_depend>
<build_depend>rosidl_default_generators</build_depend>
<exec_depend>rosidl_default_runtime</exec_depend>
<member_of_group>rosidl_interface_packages</member_of_group>
```

```cmake
cmake_minimum_required(VERSION 3.8)
project(example_msgs)

find_package(tutrc_ament REQUIRED)

tutrc_ament_init()

tutrc_ament_generate_interfaces()

tutrc_ament_final()
```
