import React from "react";
import { useState } from "react";
import { SafeAreaView, StatusBar, Text, Button } from "react-native";
import Calculator from "example-library/src/index";

const App = () => {
  const [currentResult, setResult] = useState(null);
  return (
    <SafeAreaView>
      <StatusBar barStyle={"dark-content"} />
      <Text style={{ marginLeft: 20, marginTop: 20 }}>
        3+7={currentResult ?? "??"}
      </Text>
      <Button
        title="Compute"
        onPress={async () => {
          const startTime = new Date().getTime();
          const result = await Calculator.add(3, 7);
          const endTime = new Date().getTime();
          console.log("interval = ", endTime - startTime);
          setResult(result);
        }}
      />
    </SafeAreaView>
  );
};
export default App;
