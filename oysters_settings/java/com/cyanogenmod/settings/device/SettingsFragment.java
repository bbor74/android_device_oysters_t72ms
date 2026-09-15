package com.cyanogenmod.settings.device;

import android.os.AsyncTask;
import android.os.Bundle;
import android.os.SystemProperties;
import android.preference.SwitchPreference;
import android.preference.ListPreference;
import android.preference.EditTextPreference;
import android.preference.Preference;
import android.preference.PreferenceFragment;
import android.provider.Settings;
import android.widget.Toast;
import android.util.Slog;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Arrays;

/**
 * Created by prodoomman on 19.02.15.
 */
public class SettingsFragment extends PreferenceFragment implements Preference.OnPreferenceChangeListener {
    
    private static final String TAG = "oysters_settings";
    private static final String FAKEGPS_LATITUDE_PROPERTY_NAME = "persist.fakegps.latitude";
    private static final String FAKEGPS_LONGITUDE_PROPERTY_NAME = "persist.fakegps.longitude";
    private static final String FAKEGPS_ALTITUDE_PROPERTY_NAME = "persist.fakegps.altitude";

    private static final String FAKEGPS_LATITUDE_DEFAULT = "55.085754";
    private static final String FAKEGPS_LONGITUDE_DEFAULT = "38.770379";
    private static final String FAKEGPS_ALTITUDE_DEFAULT = "310.0";

    private static final String FAKEGPS_LATITUDE = "fakegps_latitude";
    private static final String FAKEGPS_LONGITUDE = "fakegps_longitude";
    private static final String FAKEGPS_ALTITUDE = "fakegps_altitude";
    
    EditTextPreferenceEx fakegps_latitude;
    EditTextPreferenceEx fakegps_longitude;
    EditTextPreferenceEx fakegps_altitude;
    
    private class SysfsValue {
        private String fileName;
        private String value;

        private SysfsValue(String fileName, String value) {
            this.fileName = fileName;
            this.value = value;
        }

        public String getFileName() {
            return fileName;
        }

        public String getValue() {
            return value;
        }
    }

    class SysfsWriteTask extends AsyncTask<SysfsValue, Void, Integer> {

        @Override
        protected Integer doInBackground(SysfsValue... params) {
            try {
                FileOutputStream fos = new FileOutputStream(params[0].getFileName());
                fos.write(params[0].getValue().getBytes(Charset.forName("UTF-8")));
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
                return -1;
            }
            return 0;
        }

        @Override
        protected void onPostExecute(Integer result) {
            if(0 != result) {
                Toast.makeText(getActivity(), R.string.fail, Toast.LENGTH_SHORT).show();
            }
        }
    }

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.pref_oysters);

    /**    ListPreference main_storage = (ListPreference)findPreference("main_storage");
        main_storage.setOnPreferenceChangeListener(this);

        int planned_swap = SystemProperties.getInt("persist.storages.planned_swap", 0);
        main_storage.setValue(String.valueOf(planned_swap)); */
        
        fakegps_latitude = (EditTextPreferenceEx)findPreference(FAKEGPS_LATITUDE);
        fakegps_latitude.setOnPreferenceChangeListener(this);
        fakegps_latitude.setText(SystemProperties.get(FAKEGPS_LATITUDE_PROPERTY_NAME,FAKEGPS_LATITUDE_DEFAULT));

        fakegps_longitude = (EditTextPreferenceEx)findPreference(FAKEGPS_LONGITUDE);
        fakegps_longitude.setOnPreferenceChangeListener(this);
        fakegps_longitude.setText(SystemProperties.get(FAKEGPS_LONGITUDE_PROPERTY_NAME,FAKEGPS_LONGITUDE_DEFAULT));

        fakegps_altitude = (EditTextPreferenceEx)findPreference(FAKEGPS_ALTITUDE);
        fakegps_altitude.setOnPreferenceChangeListener(this);
        fakegps_altitude.setText(SystemProperties.get(FAKEGPS_ALTITUDE_PROPERTY_NAME,FAKEGPS_ALTITUDE_DEFAULT));

    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue)
    {
        /** if (preference.getKey().equals("main_storage")) {
            SystemProperties.set("persist.storages.planned_swap", (String)newValue);
            Toast.makeText(getActivity(), R.string.reboot_needed, Toast.LENGTH_LONG).show();
        }*/
        if (preference.getKey().equals(FAKEGPS_LATITUDE)) {
            SystemProperties.set(FAKEGPS_LATITUDE_PROPERTY_NAME, newValue.toString());
        }
        if (preference.getKey().equals(FAKEGPS_LONGITUDE)) {
            SystemProperties.set(FAKEGPS_LONGITUDE_PROPERTY_NAME, newValue.toString());
        }
        if (preference.getKey().equals(FAKEGPS_ALTITUDE)) {
            SystemProperties.set(FAKEGPS_ALTITUDE_PROPERTY_NAME, newValue.toString());
        }
        return true;
    }
}
