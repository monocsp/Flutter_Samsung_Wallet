package com.example.samsung_wallet;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import androidx.annotation.Nullable;

//For Samsung Wallet Import
import android.os.Build;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;
import android.net.Uri;

/** SamsungWalletPlugin */
public class SamsungWalletPlugin implements FlutterPlugin, MethodCallHandler {
  protected final static String TAG = "SamsungWalletSample";
  protected final static String ERROR_TAG = "[SAMSUNG WALLET ERROR]";

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "samsung_wallet");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

    if(call.method.equals("checkWalletSupported")){
      try{
      final String modelName = Build.MODEL;
      final String countryCode = call.argument("countryCode"); // (optional) country code (ISO_3166-2)

      final String serviceType = call.argument("serviceType"); // (mandatory, fixed) for Samsung Wallet

      if(serviceType == null){
        result.error(TAG, ERROR_TAG, " : serviceType is mandatory parameter!");
        return;
      }
  
      final String partnerCode = call.argument("partnerCode"); // (mandatory) same as partnerId (Partner ID)

      if(partnerCode == null){
        result.error(TAG, ERROR_TAG, " : partnerCode is mandatory parameter!");


      boolean isWalletSupported = checkWalletSupported(
                        modelName, countryCode, serviceType, partnerCode);
      String msg = String.format(
                        "query for model(%s), countryCode(%s), serviceType(%s), partnerCode(%s) / wallet supported? (%s)",
                        modelName,
                        countryCode,
                        serviceType,
                        partnerCode,
                        isWalletSupported);
                Log.d(TAG, msg);
        //URL impression_url ----
        
        return;
      }
      }catch(Exception e){
        result.error(TAG,ERROR_TAG,e.getMessage());
        return;
      }
      

    }


      result.notImplemented();
    
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  ///Samsung Wallet Sample Code
  public boolean checkWalletSupported(@NonNull String modelName, @Nullable String countryCode,
                                        @NonNull String serviceType, @NonNull String partnerCode) throws Exception {
        //Dead Code
        // if (modelName == null || modelName.isEmpty()) {
        //     Log.e(TAG, "model name is mandatory parameter");
        //     throw new Exception("something went wrong (failed to get device model name)");
        // }
        // if (serviceType == null || serviceType.isEmpty()) {
        //     Log.e(TAG, "serviceType is mandatory parameter");
        //     throw new Exception("something went wrong (failed to get device serviceType)");
        // }
        // if (partnerCode == null || partnerCode.isEmpty()) {
        //     Log.e(TAG, "partnerCode is mandatory parameter");
        //     throw new Exception("something went wrong (failed to get device partnerCode)");
        // }

        String urlString = makeUrl(modelName, countryCode, serviceType);
        Log.i(TAG, "urlString: " + urlString);
        try {
            URL url = new URL(urlString);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestProperty("partnerCode", partnerCode);
            connection.setRequestMethod("GET");
            int responseCode = connection.getResponseCode();
            Log.i(TAG, "responseCode: " + responseCode);
            BufferedReader bufferedReader;
            if (responseCode == 200) {
                bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            } else {
                bufferedReader = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
            }
            StringBuilder sb = new StringBuilder();
            String inputline;
            while ((inputline = bufferedReader.readLine()) != null) {
                Log.i(TAG, inputline);
                sb.append(inputline);
            }
            connection.disconnect();
            bufferedReader.close();
            // parse result
            JSONObject jsonObject = new JSONObject(sb.toString());
            String resultCode = jsonObject.getString("resultCode");
            String resultMessage = jsonObject.getString("resultMessage");
            if ("0".equals(resultCode) && "SUCCESS".equals(resultMessage)) {
                return jsonObject.getBoolean("available");
            } else {
                throw new Exception("something went wrong, resultCode(" + resultCode + "), resultMessage(" + resultMessage + ")");
            }
        } catch (IOException e) {
            Log.e(TAG, e.getMessage(), e);
            throw new Exception("something went wrong (IOException), " + e.getMessage());
        } catch (JSONException e) {
            Log.e(TAG, e.getMessage(), e);
            throw new Exception("something went wrong, receive wrong formatted response, " + e.getMessage());
        }
    }

    ///Samsung Wallet Sample Code
    protected String makeUrl(@NonNull String modelName, @Nullable String countryCode,
                             @NonNull String serviceType) {
        StringBuilder sb = new StringBuilder();
        sb.append(HOST).append('/');
        sb.append(PATH);
        sb.append('?').append("serviceType").append('=').append(serviceType);
        sb.append('&').append("modelName").append('=').append(modelName);
        if (countryCode != null && !countryCode.isEmpty()) {
            sb.append('&').append("countryCode").append('=').append(countryCode);
        }
        return sb.toString();
    }
}
