package util;

import java.io.*;

public class FileUtil {
    public static void saveImage(String root, String fname, byte[] data) throws IOException {
        root += "/images";

        File f = new File(root);
        if (!f.exists()) f.mkdir();

        f = new File(root + "/" + fname);
        FileOutputStream out = new FileOutputStream(f);
        out.write(data);
        out.close();
    }

    // generateFileName 메서드를 정의합니다.
    public static String generateFileName(String originalFileName) {
        // 현재 타임스탬프를 기반으로 한 고유한 파일 이름을 생성합니다.
        long timestamp = System.currentTimeMillis();
        int extensionIndex = originalFileName.lastIndexOf('.');
        String extension = (extensionIndex >= 0) ? originalFileName.substring(extensionIndex) : "";
        return "image_" + timestamp + extension;
    }
}
