#!/bin/bash

declare -a daftarLaporan

tampilkanMenu() {
    echo "======================================================================================="
    echo "========================= SIADU PERUMAHAN RUNGKUT ASRI TIMUR ========================="
    echo "======================================================================================="
    echo "Menu: "
    echo "1. Tambah Laporan"
    echo "2. Tampilkan Laporan"
    echo "3. Edit Laporan"
    echo "4. Hapus Laporan"
    echo "5. Cari Laporan"
    echo "6. Menu Lain"
    echo "7. Keluar dan Simpan"
    echo "Pilih menu: "
}

tambahLaporan() {
    laporanBaru=()
    read -p "Masukkan Nama: " nama
    laporanBaru+=("Nama: $nama")
    read -p "Masukkan Alamat: " alamat
    laporanBaru+=("Alamat: $alamat")
    read -p "Masukkan Nomor HP: " nomorHp
    laporanBaru+=("Nomor HP: $nomorHp")
    read -p "Masukkan Jenis Laporan: " jenisLaporan
    laporanBaru+=("Jenis Laporan: $jenisLaporan")
    read -p "Masukkan Permasalahan: " permasalahan
    laporanBaru+=("Permasalahan: $permasalahan")
    read -p "Masukkan Lokasi: " lokasi
    laporanBaru+=("Lokasi: $lokasi")
    tanggal=$(date)
    laporanBaru+=("Tanggal: $tanggal")
    daftarLaporan+=("${laporanBaru[@]}")
    echo "Laporan Kami Terima!"
}

tampilkanSemuaLaporan() {
    if [ ${#daftarLaporan[@]} -eq 0 ]; then
        echo "Belum Ada Laporan Yang Tersedia."
    else
        echo "Daftar Laporan:"
        for laporan in "${daftarLaporan[@]}"; do
            echo "$laporan"
            echo "-------------------"
            echo "-------------------"
        done
    fi
}

editLaporan() {
    read -p "Masukkan ID Laporan Yang Ingin Diedit: " idLaporan
    if [ $idLaporan -gt 0 ] && [ $idLaporan -le ${#daftarLaporan[@]} ]; then
        laporan=${daftarLaporan[$idLaporan - 1]}
        echo "Laporan yang ingin diedit:"
        echo "$laporan"

        read -p "Masukkan Nama Baru: " namaBaru
        read -p "Masukkan Alamat Baru: " alamatBaru
        read -p "Masukkan Nomor HP Baru: " nomorHpBaru
        read -p "Masukkan Jenis Laporan Baru: " jenisLaporanBaru
        read -p "Masukkan Permasalahan Baru: " permasalahanBaru
        read -p "Masukkan Lokasi Baru: " lokasiBaru

        # Update laporan
        daftarLaporan[$idLaporan - 1]="Nama: $namaBaru Alamat: $alamatBaru Nomor HP: $nomorHpBaru Jenis Laporan: $jenisLaporanBaru Permasalahan: $permasalahanBaru Lokasi: $lokasiBaru"

        echo "Laporan Berhasil Diubah!"
    else
        echo "ID Laporan Tidak Valid."
    fi
}

hapusLaporan() {
    read -p "Masukkan ID Laporan Yang Ingin Dihapus: " idLaporan
    if [ $idLaporan -gt 0 ] && [ $idLaporan -le ${#daftarLaporan[@]} ]; then
        unset "daftarLaporan[$idLaporan - 1]"
        daftarLaporan=("${daftarLaporan[@]}")
        echo "Laporan Berhasil Dihapus!"
    else
        echo "ID Laporan Tidak Valid."
    fi
}

cariLaporan() {
    read -p "Masukkan Nama untuk Pencarian: " namaCari
    if [ ${#daftarLaporan[@]} -eq 0 ]; then
        echo "Belum Ada Laporan Yang Tersedia."
    else
        ditemukan=false
        echo "Hasil Pencarian untuk Nama '$namaCari':"
        for laporan in "${daftarLaporan[@]}"; do
            if [[ $laporan == *"$namaCari"* ]]; then
                echo "$laporan"
                echo "-------------------"
                ditemukan=true
            fi
        done

        if [ "$ditemukan" = false ]; then
            echo "Tidak ditemukan laporan dengan nama '$namaCari'."
        fi
    fi
}

menuLain() {
    while true; do
        echo "Menu Lain:"
        echo "1. Membuat Folder"
        echo "2. Membuat File "
        echo "3. Delete Folder"
        echo "4. Delete File"
        echo "5. Manipulasi Hak Akses"
        echo "6. Faktorial"
        echo "7. Rekursif"
        echo "8. Fibonacci"
        echo "9. Kembali ke Menu Utama"

        read -p "Pilihan Anda (1-9): " choice

        case $choice in
            1)
                read -p "Masukkan nama folder: " folder_name
                mkdir "$folder_name"
                echo "Folder '$folder_name' telah dibuat."
                ;;
            2)
                read -p "Masukkan nama file: " file_name
                touch "$file_name"
                echo "File '$file_name' telah dibuat."
                ;;
            3)
                read -p "Masukkan nama folder yang akan dihapus: " folder_to_delete
                rm -r "$folder_to_delete"
                echo "Folder '$folder_to_delete' telah dihapus."
                ;;
            4)
                read -p "Masukkan nama file yang akan dihapus: " file_to_delete
                rm "$file_to_delete"
                echo "File '$file_to_delete' telah dihapus."
                ;;
            5)
                read -p "Masukkan nama file atau folder: " target
                read -p "Masukkan hak akses baru (misalnya 755): " permissions
                chmod "$permissions" "$target"
                echo "Hak akses untuk '$target' telah diubah menjadi $permissions."
                ;;
            6)
                read -p "Masukkan angka untuk faktorial: " num
                result=1
                for ((i=1; i<=$num; i++)); do
                    result=$((result * i))
                done
                echo "Faktorial dari $num adalah $result."
                ;;
            7)
                factorial_recursive() {
                    if [ $1 -eq 0 ] || [ $1 -eq 1 ]; then
                        echo 1
                    else
                        echo $(( $1 * $(factorial_recursive $(( $1 - 1 ))) ))
                    fi
                }

                read -p "Masukkan angka untuk rekursif: " num_recursive
                result_recursive=$(factorial_recursive $num_recursive)
                echo "Hasil rekursif dari $num_recursive adalah $result_recursive."
                ;;
            8)
                read -p "Masukkan jumlah angka dalam deret Fibonacci: " fib_count
                a=0
                b=1
                echo -n "Deret Fibonacci: "
                for ((i=0; i<$fib_count; i++)); do
                    echo -n "$a "
                    temp=$((a + b))
                    a=$b
                    b=$temp
                done
                echo
                ;;
            9)
                echo "Kembali ke Menu Utama."
                break
                ;;
            *)
                echo "Pilihan tidak valid. Silakan masukkan angka 1-9."
                ;;
        esac
    done
}

simpanLaporanKeFile() {
    if [ ${#daftarLaporan[@]} -eq 0 ]; then
        echo "Tidak ada data untuk disimpan."
    else
        echo "Simpan data ke file data.txt..."
        for laporan in "${daftarLaporan[@]}"; do
            echo "$laporan" >> data.txt
            echo "-------------------" >> data.txt
        done
        echo "Data berhasil disimpan ke data.txt."
    fi
}


pilihan=0
while [ $pilihan -ne 5 ]; do
    tampilkanMenu
    read -r pilihan
    case $pilihan in
        1) tambahLaporan ;;
        2) tampilkanSemuaLaporan ;;
        3) editLaporan ;;
        4) hapusLaporan ;;
        5) cariLaporan ;;
        6) menuLain ;;
        7)
            simpanLaporanKeFile
            echo "Program Selesai."
            ;;
        *)
            echo "Pilihan Tidak Valid. Silakan Pilih Menu Yang Benar."
            ;;
    esac
done