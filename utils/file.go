package utils

import (
	"io/ioutil"
	"os"
	"strings"
	"time"
)

type File struct {
	FileNameEnc string `json:"name"` // base64 encoded.
	FileName    string `json:"-"`
	FilePath    string
	ContentEnc  []byte `json:"content"` // not encoded?
	Content     []byte `json:"-"`
	PasswordEnc string `json:"password"`  // base64 encoded.
	Signature   string `json:"signature"` // base64 encoded.
	HMAC        string `json:"HMAC"`      // base64 encoded.
	UserID      string `json:"userID"`    // ? needed here?
	FileSize    int    `json:"fileSize"`
	// Does the server not do anything with empty fields?
	ID     int       `json:"ID"`
	Expiry time.Time `json:"expiry"`
	Sender string    `json:"sender"`
}

// ============================================================================================================================

// PUBLIC

func WriteToFile(data []byte, pathToFile string) error {
	err := ioutil.WriteFile(pathToFile, data, 777)
	return err
}

func StoreFileFromDownload(f File, path string) error {
	// WriteToFile(f.Content, path + f.Name) // permissions...
	err := ioutil.WriteFile(path+f.FileName, f.Content, 0755)
	return err
}

func ReadFromFile(pathToFile string) ([]byte, error) {
	data, err := ioutil.ReadFile(pathToFile)
	return data, err
}

func IsFile(pathToFile string) bool {
	if s, err := os.Stat(pathToFile); os.IsNotExist(err) || s.IsDir() || err != nil {
		return false
	}
	return true
}

func DeleteFile(pathToFile string) bool {
	os.Remove(pathToFile)
	return true
}

func StripFilePathBase(pathToFile string) string {
	return strings.Replace(pathToFile, "file://", "", -1)
}

// ============================================================================================================================

// EOF
