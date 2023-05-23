package com.monocsp.samsung_wallet;

import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStreamReader;

import android.util.Log;

import java.util.concurrent.ExecutionException;
import java.util.HashMap;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.app.Activity;
import android.Manifest;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.PluginRegistry;

import androidx.annotation.Nullable;

//For Samsung Wallet Import
import android.os.Build;
import android.content.Intent;
import android.content.pm.PackageManager;

import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;


import org.json.JSONException;
import org.json.JSONObject;

import javax.net.ssl.HttpsURLConnection;

import java.net.MalformedURLException;

import android.net.Uri;

//For Excutor
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Callable;
import java.util.concurrent.Future;
import java.util.concurrent.Executors;

/**
 * SamsungWalletPlugin
 */
public class SamsungWalletPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
    protected final static String TAG = "SamsungWalletSample";
    protected final static String ERROR_TAG = "[SAMSUNG WALLET ERROR]";
    protected static final String HOST = "https://api-us3.mpay.samsung.com";
    protected static final String PATH = "wallet/cmn/v2.0/device/available";

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Activity activity;

    @Override
    public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
        // TODO: your plugin is now attached to an Activity
        activity = activityPluginBinding.getActivity();
        activityPluginBinding.addActivityResultListener(this);

    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_samsung_wallet");
        channel.setMethodCallHandler(this);
    }


    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
        // TODO: your plugin is now attached to a new Activity
        // after a configuration change.
        activity = activityPluginBinding.getActivity();
        activityPluginBinding.addActivityResultListener(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

        if (!checkInternetPermission()) {
            result.error(TAG, ERROR_TAG, " : Please Check Internet Permission in AndroidManifest.xml");
            return;
        }

        if (!checkAccessNetworkStatePermission()) {
            result.error(TAG, ERROR_TAG, " : Please Check AccessNetworkState Permission in AndroidManifest.xml");
            return;
        }


        if (call.method.equals("initialized")) {
            final String modelName = Build.MODEL;
            final String countryCode = call.argument("countryCode"); // (optional) country code (ISO_3166-2)
            final String serviceType = call.argument("serviceType"); // (mandatory, fixed) for Samsung Wallet
            final String partnerCode = call.argument("partnerCode"); // (mandatory) same as partnerId (Partner ID)
            final String impressionURL = call.argument("impressionURL");

            HashMap<String, Object> response = new HashMap<>();

            try {
                if (serviceType == null || serviceType.isEmpty()) {
                    result.error(TAG, ERROR_TAG, " : serviceType is mandatory parameter!");
                    return;
                }

                if (partnerCode == null || partnerCode.isEmpty()) {
                    result.error(TAG, ERROR_TAG, " : partnerCode is mandatory parameter!");
                    return;
                }
                boolean isWalletSupported = checkWalletAsyncTask(
                        modelName, countryCode, serviceType, partnerCode);
                response.put("walletSupported", isWalletSupported);

            } catch (Exception e) {
                result.error(TAG, ERROR_TAG, e.getMessage());
                return;
            }

            try {
                boolean isConnectedImpressionUrl = openConnectionImpressionUrl(impressionURL);
                response.put("connectedImpressionUrl", isConnectedImpressionUrl);
            } catch (IOException e) {
                result.error(TAG, ERROR_TAG, e.getMessage());
                return;
            }
            result.success(response);
            return;
        }

        if (call.method.equals("checkWallet")) {
            final String modelName = Build.MODEL;
            final String countryCode = call.argument("countryCode"); // (optional) country code (ISO_3166-2)
            final String serviceType = call.argument("serviceType"); // (mandatory, fixed) for Samsung Wallet
            final String partnerCode = call.argument("partnerCode"); // (mandatory) same as partnerId (Partner ID)
            try {

                if (serviceType == null || serviceType.isEmpty()) {
                    result.error(TAG, ERROR_TAG, " : serviceType is mandatory parameter!");
                    return;
                }

                if (partnerCode == null || partnerCode.isEmpty()) {
                    result.error(TAG, ERROR_TAG, " : partnerCode is mandatory parameter!");
                    return;
                }

                boolean isWalletSupported = checkWalletAsyncTask(
                        modelName, countryCode, serviceType, partnerCode);
                result.success(isWalletSupported);
            } catch (Exception e) {
                result.error(TAG, ERROR_TAG, e.getMessage());
                return;
            }
            return;
        }

        if (call.method.equals("addCardToSamsungWallet")) {
            final String cData = call.argument("cData");
            final String cardId = call.argument("cardId");
            final String clickURL = call.argument("clickURL");

            if (cData == null || cData.isEmpty()) {
                result.error(TAG, ERROR_TAG, " : cData is mandatory parameter!");
                return;
            }


            if (cardId == null || cardId.isEmpty()) {
                result.error(TAG, ERROR_TAG, " : cardId is mandatory parameter!");
                return;
            }


            if (clickURL == null || clickURL.isEmpty()) {
                result.error(TAG, ERROR_TAG, " : clickURL is mandatory parameter!");
                return;
            }

            boolean isSuccessAddCard = addCardToSamsungWallet(clickURL, cardId, cData);

            result.success(isSuccessAddCard);
            return;
        }


        result.notImplemented();
        return;


    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        activity = null;
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        activity = null;
    }

    @Override
    public void onDetachedFromActivity() {
        activity = null;

    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {

        return false;
    }


    private boolean addCardToSamsungWallet(@NonNull String clickUrl, @NonNull String cardId, @NonNull String cData) {
        URL click_url = null;
        try {
            click_url = new URL(clickUrl);
        } catch (MalformedURLException e) {
            Log.e(TAG, e.getMessage(), e);
            return false;
        }
        try {
            HttpsURLConnection myConnection =
                    (HttpsURLConnection) click_url.openConnection();
        } catch (IOException e) {
            e.printStackTrace();
            Log.e(TAG, e.getMessage(), e);
            return false;
        }
        try {
            Intent urlintent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://a.swallet.link/atw/v1/" + cardId + "#Clip?cdata=" + cData));
            activity.startActivity(urlintent);
            return true;
        } catch (Exception e) {
            Log.e(TAG, e.getMessage(), e);
            return false;
        }

    }

    ///Check WalletSupported async task
    private boolean checkWalletAsyncTask(@NonNull String modelName, @Nullable String countryCode,
                                         @NonNull String serviceType, @NonNull String partnerCode) throws Exception {
        boolean result = false;
        ExecutorService excutor = Executors.newSingleThreadExecutor();

        Future<Boolean> isWalletSupported = excutor.submit(new Callable<Boolean>() {
            public Boolean call() throws Exception {
                try {
                    return checkWalletSupported(
                            modelName, countryCode, serviceType, partnerCode);

                } catch (Exception e) {
                    Log.e(TAG, e.getMessage(), e);
                    return false;
                } finally {
                    excutor.shutdown();
                }

            }

        });

        try {
            result = isWalletSupported.get(); // waiting async task
            String msg = String.format(
                    "query for model(%s), countryCode(%s), serviceType(%s), partnerCode(%s) / wallet supported? (%s)",
                    modelName,
                    countryCode,
                    serviceType,
                    partnerCode,
                    result);
            Log.d(TAG, msg);

        } catch (InterruptedException e) {
            // Exception : Interrupted Thread
            Log.e(TAG, e.getMessage(), e);
        } catch (ExecutionException e) {
            // Exception other reason
            Log.e(TAG, e.getMessage(), e);
        }
        return result;
    }

    private boolean openConnectionImpressionUrl(@NonNull String impressionUrl) throws IOException {
        URL impression_url = null;
        try {
            impression_url = new URL(impressionUrl);
        } catch (MalformedURLException e) {
            e.printStackTrace();
            Log.e(TAG, e.getMessage(), e);
            return false;
        }
        try {
            HttpsURLConnection myConnection =
                    (HttpsURLConnection) impression_url.openConnection();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            Log.e(TAG, e.getMessage(), e);
            return false;
        }

    }


    /// Samsung Wallet Sample Code
    public boolean checkWalletSupported(@NonNull String modelName, @Nullable String countryCode,
                                        @NonNull String serviceType, @NonNull String partnerCode) throws Exception {
        // Dead Code
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
        // Dead Code

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

    private boolean checkAccessNetworkStatePermission() {
        return ContextCompat.checkSelfPermission(this.activity.getApplicationContext(), Manifest.permission.ACCESS_NETWORK_STATE) == PackageManager.PERMISSION_GRANTED;
    }

    private boolean checkInternetPermission() {

        return ContextCompat.checkSelfPermission(this.activity.getApplicationContext(), Manifest.permission.INTERNET) == PackageManager.PERMISSION_GRANTED;
    }

}
