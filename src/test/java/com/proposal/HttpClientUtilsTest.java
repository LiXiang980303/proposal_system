package com.proposal;

import org.junit.Test;
import com.proposal.util.HttpClientUtils;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created by niu_ben on 2016/12/28.
 */
public class HttpClientUtilsTest {
    @Test
    public void testPost() {
        // POST 同步方法
        Map<String, String> params = new HashMap<String, String>();
        params.put("username", "admin");
        params.put("password", "ASDqwe123");
        HttpClientUtils.getInstance().httpPost("http://172.18.116.162:8081/0128-2015-0001.pdf", params);
    }

    @Test
    public void testDownload(){
        HttpClientUtils.getInstance().download("http://www.gamersky.com/showimage/id_gamersky.shtml?http://img1.gamersky.com/image2016/08/20160820_ls_141_7/gamersky_04origin_07_201682020333CA.jpg","");
    }


    /**
     * 测试下载文件 异步下载
     */
    @Test
    public void test() {

        HttpClientUtils.getInstance().download("http://newbbs.qiniudn.com/phone.png", "test.png",
                new HttpClientUtils.HttpClientDownLoadProgress() {
                    @Override
                    public void onProgress(int progress) {
                        System.out.println("download progress = " + progress);
                    }
                });

        // POST 同步方法
        Map<String, String> params = new HashMap<String, String>();
        params.put("username", "admin");
        params.put("password", "admin");
        HttpClientUtils.getInstance().httpPost("http://192.168.31.183:8080/SSHMySql/register", params);

        // GET 同步方法
        HttpClientUtils.getInstance().httpGet("http://wthrcdn.etouch.cn/weather_mini?city=北京");

        // 上传文件 POST 同步方法
        try {
            Map<String, String> uploadParams = new LinkedHashMap<String, String>();
            uploadParams.put("userImageContentType", "image");
            uploadParams.put("userImageFileName", "testaa.png");
            HttpClientUtils.getInstance().uploadFileImpl(
                    "http://192.168.31.183:8080/SSHMySql/upload", "android_bug_1.png",
                    "userImage", uploadParams);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
